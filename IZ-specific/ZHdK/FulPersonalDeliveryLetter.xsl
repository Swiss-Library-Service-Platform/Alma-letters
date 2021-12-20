<?xml version="1.0" encoding="utf-8"?>
<!-- sytle.xsl, 20200918, SLSP -->
<!-- sytle.xsl, 20201006, UBS -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl"/>
	<!-- No senderReceiver.xsl, address fix -->
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="recordTitle.xsl"/>
	<xsl:template match="/">
		<html>
			<head>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
				<xsl:call-template name="generalStyle"/>
			</head>
			<body font-family="sans-serif">
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss"/>
					<!-- style.xsl -->
					<!-- <xsl:call-template name="head" /> No header.xsl -->
				</xsl:attribute>
				<div class="messageArea">
					<div class="messageBody">
						<div style="height=28cm">
							<div style="height=9cm">
								<table cellspacing="0" cellpadding="5" border="0" width="100%">
									<xsl:attribute name="style">
										<xsl:call-template name="listStyleCss"/>
									</xsl:attribute>
									<tr>
										<table>
											<tr>
												<td width="45%" align="left">
													<table>
														<tr>
															<xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="notification_data/user_for_printing/last_name"/>
														</tr>
														<xsl:if test="string-length(notification_data/user_for_printing/address1)!=0">
															<tr>
																<td>
																	<xsl:value-of select="notification_data/user_for_printing/address1"/>
																</td>
															</tr>
														</xsl:if>
														<xsl:if test="string-length(notification_data/user_for_printing/address2)!=0">
															<tr>
																<td>
																	<xsl:value-of select="notification_data/user_for_printing/address2"/>
																</td>
															</tr>
														</xsl:if>
														<xsl:if test="string-length(notification_data/user_for_printing/address3)!=0">
															<tr>
																<td>
																	<xsl:value-of select="notification_data/user_for_printing/address3"/>
																</td>
															</tr>
														</xsl:if>
														<xsl:if test="string-length(notification_data/user_for_printing/address4)!=0">
															<tr>
																<td>
																	<xsl:value-of select="notification_data/user_for_printing/address4"/>
																</td>
															</tr>
														</xsl:if>
														<xsl:if test="string-length(notification_data/user_for_printing/address5)!=0">
															<tr>
																<td>
																	<xsl:value-of select="notification_data/user_for_printing/address5"/>
																</td>
															</tr>
														</xsl:if>
														<tr>
															<td>
																<xsl:value-of select="notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="notification_data/user_for_printing/city"/>
															</td>
														</tr>
														<tr>
															<td>
																<xsl:value-of select="notification_data/user_for_printing/country_display"/>
															</td>
														</tr>
													</table>
												</td>
											<!--	<td width="30%"/> -->
												<td width="35%">
													<table>
														<tr>
															<td>
																<xsl:value-of select="/notification_data/phys_item_display/owning_library_details/address1"/>
															</td>
														</tr>
														<tr>
															<td>
																<xsl:value-of select="/notification_data/phys_item_display/owning_library_details/address2"/>
															</td>
														</tr>
														<xsl:if test="string-length(notification_data/phys_item_display/owning_library_details/address3)!=0">
															<tr>
																<td>
																	<xsl:value-of select="notification_data/phys_item_display/owning_library_details/address3"/>
																</td>
															</tr>
														</xsl:if>
														<xsl:if test="string-length(notification_data/phys_item_display/owning_library_details/address4)!=0">
															<tr>
																<td>
																	<xsl:value-of select="notification_data/phys_item_display/owning_library_details/address4"/>
																</td>
															</tr>
														</xsl:if>
														<xsl:if test="string-length(notification_data/phys_item_display/owning_library_details/address5)!=0">
															<tr>
																<td>
																	<xsl:value-of select="notification_data/phys_item_display/owning_library_details/address5"/>
																</td>
															</tr>
														</xsl:if>
														<tr>
															<td>
																<xsl:value-of select="notification_data/phys_item_display/owning_library_details/postal_code"/>&#160;<xsl:value-of select="notification_data/phys_item_display/owning_library_details/city"/>
															</td>
														</tr>
														<tr>
															<xsl:value-of select="notification_data/phys_item_display/owning_library_details/country_display"/>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</tr>
								</table>
							</div>
							<div style="height=16cm">
							<br />
							<br />
														<br />
								<table width="100%" cellspacing="0" cellpadding="5" border="0">
									<tr>
										<td>
											<b>
												@@letterName@@
											</b>
										</td>
										<td align="right">
											<xsl:value-of select="notification_data/general_data/current_date"/>
										</td>
									</tr>
								</table>
								<br/>
								<br/>
								<xsl:call-template name="toWhomIsConcerned"/>
								<br></br>
								<table cellspacing="0" cellpadding="5" border="0">
									<tr>
										<td>
											@@we_sent@@
								
											<xsl:value-of select="notification_data/request/create_date" />.
									
								
										</td>
									</tr>
									<tr>
										<td>
											<xsl:value-of select="notification_data/phys_item_display/title"/>
											<br/>
											<xsl:value-of select="notification_data/phys_item_display/author"/>
											<br/>
											<xsl:value-of select="notification_data/phys_item_display/imprint"/>
										</td>
									</tr>
									<tr>
										<td>
											<br/>
											<br/>
											<xsl:value-of select="//notification_data/phys_item_display/call_number"/>&#160;|&#160;<xsl:value-of select="/notification_data/phys_item_display/location_name"/>&#160;|&#160;<xsl:value-of select="/notification_data/phys_item_display/library_name"/>
										</td>	
									</tr>
									<tr>
										<td>
											<br></br>
											<b>@@due_date@@:</b> &#160;<xsl:value-of select="substring(notification_data/due_date,1,10)"/>
										</td>
									</tr>
								</table>
								<br/>
								<br/>
								<table>
									<tr>
										<td>@@sincerely@@<br/>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
				<xsl:call-template name="lastFooter"/>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
