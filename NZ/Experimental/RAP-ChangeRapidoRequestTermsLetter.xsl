<?xml version="1.0" encoding="utf-8"?>
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

			    <table role='presentation'  cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							<h3>@@header@@</h3>
						</td>
					</tr>
				</table>

				<div class="messageArea">
					<div class="messageBody">
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td>
									@@start@@
								</td>
							</tr>
						</table>

                        <br/>
                        
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss"/>
								<!-- style.xsl -->
							</xsl:attribute>
							<xsl:if test="notification_data/request/external_request_id !=''">
								<tr>
									<td>
										<strong> @@requestId@@: </strong>
										<xsl:value-of select="notification_data/request/external_request_id"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/title !=''">
								<tr>
									<td>
										<strong> @@title@@: </strong>
										<xsl:value-of select="notification_data/request/title"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/create_date_str !=''">
								<tr>
									<td>
										<strong> @@requestDate@@: </strong>
										<xsl:value-of select="notification_data/request/create_date_str"/>
									</td>
								</tr>
							</xsl:if>
						</table>
						
						<br/>
												
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
								<xsl:if test="notification_data/old_terms_exist='true'">
									<tr>
										<td>
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
											<xsl:if test="notification_data/old_cost ='' and notification_data/new_cost !=''">
												@@costIsUnkown@@
											</xsl:if>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/old_terms_exist='false'">
									<tr>
										<td>
											@@unknownTerms@@
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/new_terms_exist='true'">
									<tr>
										<td>
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
											<xsl:if test="notification_data/new_cost ='' and notification_data/old_cost !=''">
												@@costIsUnkown@@
											</xsl:if>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/new_terms_exist='false'">
									<tr>
										<td>
											@@toUnknownTerms@@
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/default_pickup_location != '' and notification_data/preferred_library != '' and notification_data/preferred_inst != ''">
									<tr>
										<td>
											<strong> @@pickupLocationChanged@@ </strong>
											<strong><xsl:value-of select="notification_data/preferred_inst"/>-</strong>
											<strong><xsl:value-of select="notification_data/preferred_library"/></strong>
											<strong> @@defaultPickupLocation@@ </strong>
											<strong><xsl:value-of select="notification_data/default_pickup_location"/></strong>
										</td>
									</tr>
								</xsl:if>
						</table>
						<br/>
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<xsl:if test="notification_data/new_terms_exist='true'">
								<tr>
									<td>
										@@termsChange@@
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
						</table>
						<br/>
						
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<xsl:if test="notification_data/new_pickup_date !=''">
								<tr>
									<td>
										@@newPickupDate@@:
										<xsl:value-of select="notification_data/new_pickup_date"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/new_due_date !=''">
								<tr>
									<td>
										@@newDueDate@@:
										<xsl:value-of select="notification_data/new_due_date"/>
									</td>
								</tr>
							</xsl:if>
						</table>
						
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<xsl:if test="notification_data/new_delivery_date!=''">
								<tr>
									<td>
										@@newDeliveryDate@@:
										<xsl:value-of select="notification_data/new_delivery_date"/>
									</td>
								</tr>
							</xsl:if>
						</table>
						
						<br/>
						
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td>
									@@end@@
								</td>
							</tr>
						</table>

						<br/><br/>

						<table role='presentation' >
							<tr>
								<td>@@signature@@</td>
							</tr>
							<tr>
								<td>
									<xsl:value-of select="notification_data/organization_unit/name" />
								</td>
							</tr>
							<xsl:if test="notification_data/organization_unit/address/line1 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line1" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line2 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line2" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line3 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line3" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line4 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line4" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line5 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line5" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/city !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/city" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/country !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/country" />
									</td>
								</tr>

							</xsl:if>
						</table>
					</div>
				</div>
				<xsl:call-template name="lastFooter" />
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>