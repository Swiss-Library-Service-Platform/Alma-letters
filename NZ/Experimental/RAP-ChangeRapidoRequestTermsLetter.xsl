<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP version 11/2022
Dependancy:
	header - head
	style - generalStyle, bodyStyleCss, listStyleCss -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />
	<xsl:template match="/">
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
					<xsl:if test="notification_data/new_terms_exist='true'">
						<tr>
							<td>
								@@termsChange@@
							</td>
						</tr>
					</xsl:if>
					
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
							<xsl:if test="notification_data/new_terms_exist='true'">
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
							</xsl:if>
							<xsl:if test="notification_data/new_terms_exist='false'">
								<br />
								@@toUnknownTerms@@
							</xsl:if>
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
								@@newPickupDate@@:
								<xsl:value-of select="notification_data/new_pickup_date"/>
							</xsl:if>
							<xsl:if test="notification_data/new_due_date !=''">
								<br />
								@@newDueDate@@:
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
							<br />
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
							<xsl:if test="notification_data/organization_unit/address/line1 !=''">
								<xsl:value-of select="notification_data/organization_unit/address/line1" />
							</xsl:if>
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