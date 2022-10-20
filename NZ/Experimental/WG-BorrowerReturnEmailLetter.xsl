<?xml version="1.0" encoding="utf-8"?>
<!-- WG: Letters 10/2022
	Dependancy:
		header - head
		style - generalStyle, bodyStyleCss, listStyleCss
		recordTitle - SLSP-multilingual
		10/2022 -->
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
			<head>
				<xsl:call-template name="generalStyle" />
			</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss" />
					<!-- style.xsl -->
				</xsl:attribute>
				<xsl:call-template name="head" />
				<!-- header.xsl -->
				<div class="messageArea">
					<div class="messageBody">
                        <table cellspacing="0" cellpadding="5" border="0">
                            <xsl:attribute name="style">
								<xsl:call-template name="listStyleCss"/>
								<!-- style.xsl -->
							</xsl:attribute>
							<tr>
                                <td>
                                    <br/>
                                    @@header@@
                                </td>
                            </tr>
							<tr>
								<td>
									@@request@@
								</td>
							</tr>
							<tr>
								<td>
									<br />
									<strong><xsl:value-of select="notification_data/request/display/title"/></strong>
									<xsl:if test="notification_data/request/display/author">
										<br/>
										<xsl:value-of select="notification_data/request/display/author" />
									</xsl:if>
									<!--SLSL added imprint-->
									<xsl:if test="notification_data/phys_item_display/publication_place">
										<br/>
										<xsl:value-of select="notification_data/phys_item_display/publication_place"/>:&#160;
										<xsl:value-of select="notification_data/phys_item_display/publisher"/>,&#160;
										<xsl:value-of select="notification_data/phys_item_display/publication_date"/>
									</xsl:if>
								</td>
							</tr>
                            <tr>
								<td>
									<b> @@requestId@@: </b>
									<xsl:value-of select="notification_data/request/external_request_id"/>
								</td>
							</tr>
							<tr>
								<td>
									<b> @@requestDate@@: </b>
									<xsl:value-of select="notification_data/request/create_date_str"/>
								</td>
							</tr>
							<tr>
								<td>
									<b> @@returnDate@@: </b>
									<xsl:value-of select="notification_data/return_date"/>
								</td>
							</tr>
							<xsl:if test="notification_data/note_to_partner != ''">
								<tr>
									<td>
										<b>@@note@@: </b>
										<xsl:value-of select="notification_data/note_to_partner"/>
									</td>
								</tr>
							</xsl:if>
							<tr>
								<td>
									<br />
									<xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Thank you very much for the loan.'"/>
										<xsl:with-param name="fr">
											<![CDATA[Merci beaucoup pour le prêt.]]>
										</xsl:with-param>
										<xsl:with-param name="it" select="'Grazie mille per il prestito.'"/>
										<xsl:with-param name="de" select="'Vielen Dank für die Leihgabe.'"/>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									<br />@@signature@@
								</td>
							</tr>
							<xsl:if test="notification_data/request/line1 =''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/library/address/line1" />
										</td>
									</tr>
								<xsl:if test="notification_data/library/address/line2 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/library/address/line2" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/library/address/line3 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/library/address/line3" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/library/address/line4 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/library/address/line4" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/library/address/line5 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/library/address/line5" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/library/address/city !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/library/address/postal_code" />&#160;<xsl:value-of select="notification_data/library/address/city" />
										</td>
									</tr>
								</xsl:if>
							</xsl:if>
							<xsl:if test="notification_data/request/line1 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/request/line1" />
										</td>
									</tr>
								<xsl:if test="notification_data/request/line2 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/request/line2" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/request/line3 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/request/line3" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/request/line4 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/request/line4" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="notification_data/request/line5 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/request/line5" />
										</td>
									</tr>
								</xsl:if>
							</xsl:if>
							<tr>
								<td><br/><i>powered by SLSP</i></td>
							</tr>
						</table>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>