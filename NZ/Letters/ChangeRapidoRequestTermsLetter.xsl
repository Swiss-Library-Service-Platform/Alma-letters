<?xml version="1.0" encoding="utf-8"?>
<!-- WG version 02/2022
	03/2024 - added different layout when the terms are the same but the pickup date is different
	12/2024 - terminate the letter creation if the price of the request has not changed

Dependancy:
	header - head
	style - generalStyle, bodyStyleCss, listStyleCss
	recordTitle - SLSP-userAccount -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<!-- Checks whether the old terms and new terms are the same. If they are the same, returns false, otherwise returns true. -->
	<xsl:template name="termsChanged">
		<xsl:choose>
			<xsl:when test="notification_data/old_delivey_time = notification_data/ngrs_request/delivery_time
			and notification_data/old_loan_period = notification_data/ngrs_request/loan_period
			and notification_data/old_cost = notification_data/new_cost and notification_data/default_pickup_location = notification_data/preferred_library">
				<xsl:value-of select="'false'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'true'"/>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>

	<!-- Checks whether the terms for price has changed. If the price is the same, returns false, otherwise returns true. -->
	<xsl:template name="priceChanged">
		<xsl:choose>
			<xsl:when test="notification_data/old_cost = notification_data/new_cost">
				<xsl:value-of select="'false'"/>
			</xsl:when>
			<xsl:when test="string-length(notification_data/new_cost) = 0">
				<xsl:value-of select="'false'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'true'"/>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>

	<!-- Checks whether the old pickup date and new pickup date are the same. If they are the same, returns false, otherwise returns true. -->
	<xsl:template name="pickupDateChanged">
		<xsl:choose>
			<xsl:when test="notification_data/old_pickup_date = notification_data/new_pickup_date">
				<xsl:value-of select="'false'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'true'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="/">
		<xsl:variable name="termsChanged">
			<xsl:call-template name="termsChanged"/>
		</xsl:variable>
		<xsl:variable name="pickupDateChanged">
			<xsl:call-template name="pickupDateChanged"/>
		</xsl:variable>
		<xsl:variable name="priceChanged">
			<xsl:call-template name="priceChanged"/>
		</xsl:variable>
		<!-- Terminate the letter generation if the price of the request has not changed. -->
		<xsl:if test="$priceChanged = 'false'">
			<xsl:message terminate="yes">Price has not changed.</xsl:message>
		</xsl:if>
		<br/>
		<html>
			<xsl:if test="notification_data/languages/string">
				<xsl:attribute name="lang">
					<xsl:value-of select="notification_data/languages/string"/>
				</xsl:attribute>
			</xsl:if>

			<head>
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>

				<xsl:call-template name="generalStyle" />
			</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss" />
					<!-- style.xsl -->
				</xsl:attribute>
				<xsl:call-template name="head" />
				<!-- header.xsl -->
				<table role='presentation'  cellspacing="5" cellpadding="5" border="0">
					<xsl:attribute name="style">
						<!-- <xsl:call-template name="listStyleCss"/> -->
						<!-- style.xsl -->
					</xsl:attribute>
					<tr>
						<td>
							@@header@@
						</td>
					</tr>
					<tr>
						<td>
							@@start@@
						</td>
					</tr>				
					<tr>
						<td>
							<strong><xsl:value-of select="notification_data/request/display/title"/></strong>
							<xsl:if test="notification_data/request/display/author !=''">
								<br /><xsl:value-of select="notification_data/request/display/author" />
							</xsl:if>
							<!-- Logic to display the imprint correctly -->
							<xsl:if test="notification_data/request/display/publisher or
							notification_data/request/display/place_of_publication or
							notification_data/request/display/publication_date">
								<br />
								<xsl:if test="notification_data/request/display/publisher !=''">
									<xsl:value-of select="notification_data/request/display/publisher" />
								</xsl:if>
								<xsl:if test="notification_data/request/display/place_of_publication !=''">
									<xsl:if test="notification_data/request/display/publisher !=''">:&#160;</xsl:if>
									<xsl:value-of select="notification_data/request/display/place_of_publication" />
								</xsl:if>
								<xsl:if test="notification_data/request/display/publication_date !=''">
									<xsl:if test="notification_data/request/display/publisher !='' or notification_data/request/display/place_of_publication !=''">,&#160;</xsl:if>
									<xsl:value-of select="notification_data/request/display/publication_date" />
								</xsl:if>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td>
							<strong>@@requestId@@: </strong>
							<xsl:value-of select="notification_data/request/external_request_id"/>
							<br />
							<strong>@@requestDate@@: </strong>
							<xsl:value-of select="notification_data/request/create_date_str"/>
						</td>
					</tr>
					
					<xsl:choose>
						<xsl:when test="notification_data/new_terms_exist='true'
						and $termsChanged = 'false'
						and $pickupDateChanged ='true'">
						<!-- Terms have not changed but only the pickup date -->
							<tr>
								<td>@@policyChanged@@</td>
							</tr>
						</xsl:when>
						<xsl:when test="notification_data/new_terms_exist='true'">
						<!-- Terms have changed-->
							<tr>
								<td>
									@@termsChange@@
								</td>
							</tr>
						</xsl:when>
					</xsl:choose>
					<tr>
						<td>
							<xsl:if test="notification_data/old_terms_exist='true'">
								<xsl:if test="notification_data/old_delivey_time != '' and notification_data/old_loan_period != ''">
									@@from@@
									<xsl:value-of select="notification_data/old_delivey_time" />
									@@keepFor@@
									<xsl:value-of select="notification_data/old_loan_period" />
									@@days@@
								</xsl:if>	
								<xsl:if test="notification_data/old_delivey_time = ''">
									@@fromRota@@
									@@deliveryNotExist@@
									<xsl:value-of select="notification_data/old_loan_period" />
									@@days@@
								</xsl:if>	
								<xsl:if test="notification_data/old_loan_period = ''">
									@@from@@
									<xsl:value-of select="notification_data/old_delivey_time" />
									@@loanPeriodNotExist@@
								</xsl:if>				
								<xsl:if test="notification_data/old_cost !=''">
									@@costToPatron@@
									<xsl:value-of select="notification_data/old_cost" />
									<xsl:value-of select="' '" />
									<xsl:value-of select="notification_data/currency" />
								</xsl:if>
								<!-- <xsl:if test="notification_data/old_cost ='' and notification_data/new_cost !=''">
									@@costIsUnkown@@
								</xsl:if> -->
							</xsl:if>
							<xsl:if test="notification_data/old_terms_exist='false'">
								@@unknownTerms@@
							</xsl:if>
							<xsl:choose>
								<!-- new terms are the same as old terms but pickup date is different -->
								<xsl:when test="notification_data/new_terms_exist='true'
								and $termsChanged = 'false'
								and $pickupDateChanged ='true'">
								</xsl:when>
								<!-- new terms are different from old terms -->
								<xsl:when test="notification_data/new_terms_exist='true'">
									<br />
									<strong>
									<xsl:if test="notification_data/ngrs_request/delivery_time != '0' and notification_data/ngrs_request/loan_period != '0'">
										@@to@@
										<xsl:value-of select="notification_data/ngrs_request/delivery_time" />
										@@keepFor@@
										<xsl:value-of select="notification_data/ngrs_request/loan_period" />
										@@days@@
									</xsl:if>	
									<xsl:if test="notification_data/ngrs_request/delivery_time = '0'">
										@@toRota@@
										@@deliveryNotExist@@
										<xsl:value-of select="notification_data/ngrs_request/loan_period" />
										@@days@@
									</xsl:if>	
									<xsl:if test="notification_data/ngrs_request/loan_period = '0'">
										@@to@@
										<xsl:value-of select="notification_data/ngrs_request/delivery_time" />
										@@loanPeriodNotExist@@
									</xsl:if>		
									<xsl:if test="notification_data/new_cost !=''">
										@@costToPatron@@
										<xsl:value-of select="notification_data/new_cost" />
										<xsl:value-of select="' '" />
										<xsl:value-of select="notification_data/currency" />
									</xsl:if>
									<!-- <xsl:if test="notification_data/new_cost ='' and notification_data/old_cost !=''">
										@@costIsUnkown@@
									</xsl:if> -->
									</strong>
								</xsl:when>
								<xsl:when test="notification_data/new_terms_exist='false'">
									<br />
									@@toUnknownTerms@@
								</xsl:when>
							</xsl:choose>
						</td>
					</tr>
					<xsl:if test="notification_data/default_pickup_location != '' and notification_data/preferred_library != '' and notification_data/preferred_inst != ''">
						<tr>
							<td>
								<strong>@@pickupLocationChanged@@ </strong>
								<strong><xsl:value-of select="notification_data/preferred_inst"/>-</strong>
								<strong><xsl:value-of select="notification_data/preferred_library"/></strong>
								<strong>@@defaultPickupLocation@@ </strong>
								<strong><xsl:value-of select="notification_data/default_pickup_location"/></strong>
							</td>
						</tr>
					</xsl:if>
					
					<xsl:if test="notification_data/new_terms_exist='false'">
							<tr>
								<td>
									@@prevTermsNoValid@@
									<br/>
									@@weWillUpdate@@
								</td>
							</tr>
					</xsl:if>
					<tr>
						<td>
							<xsl:if test="notification_data/new_pickup_date !=''">
								<strong>@@newPickupDate@@: </strong>
								<xsl:value-of select="notification_data/new_pickup_date"/>
							</xsl:if>
							<xsl:if test="notification_data/new_due_date !=''">
								<br />
								<strong>@@newDueDate@@: </strong>
								<xsl:value-of select="notification_data/new_due_date"/>
							</xsl:if>
							<xsl:if test="notification_data/new_delivery_date!=''">
								<br />
								@@newDeliveryDate@@:
								<xsl:value-of select="notification_data/new_delivery_date"/>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td>
							<xsl:call-template name="SLSP-userAccount"/>
						</td>
					</tr>
					<tr>
						<td>
							@@end@@
						</td>
					</tr>
					<tr>
						<td>
							<br />
							@@signature@@
						</td>
					</tr>
					<tr>
						<td>
							<xsl:choose>
								<xsl:when test="notification_data/organization_unit/address/line1 !=''">
									<xsl:value-of select="notification_data/organization_unit/address/line1" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="notification_data/organization_unit/name" />
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="notification_data/organization_unit/address/line2 !=''">
								<br />
								<xsl:value-of select="notification_data/organization_unit/address/line2" />
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line3 !=''">
								<br />
								<xsl:value-of select="notification_data/organization_unit/address/line3" />
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line4 !=''">
								<br />
								<xsl:value-of select="notification_data/organization_unit/address/line4" />
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line5 !=''">
								<br />
								<xsl:value-of select="notification_data/organization_unit/address/line5" />
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/city !=''">
								<br />
								<xsl:value-of select="notification_data/organization_unit/address/postal_code" />
								&#160;<xsl:value-of select="notification_data/organization_unit/address/city" />
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/country !=''">
								<br />
								<xsl:value-of select="notification_data/organization_unit/address/country" />
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td>
							<br/>
							<i>powered by SLSP</i>
						</td>
					</tr>
				</table>
				<!-- <xsl:call-template name="lastFooter" /> -->
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>