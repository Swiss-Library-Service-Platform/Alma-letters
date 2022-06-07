<?xml version="1.0" encoding="utf-8"?>
<!-- Resource Sharing Return Slip Letter , UBS, 20210419 -->
<!-- Noetige Anpassungen fuer Druckausgabe in transparenten Klebeumschlag. -->
<!-- ACHTUNG: fuer Versand von physischen Monografien. Falls weitere Partner weitere Anpassungen ggfs. noetig!!! Stand/Auskunft Brigitte Sprimgmann, 20210301 -->
<!-- Anpassung Anzeige für Ausländische Partnerbibliotheken 20211109/nme -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:include href="header.xsl"/>
	<xsl:include href="senderReceiver.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:include href="recordTitle.xsl"/>
	<!-- -->
	<xsl:template match="/">
		<html>
			<head>
				<xsl:call-template name="generalStyle"/>
			</head>
			<body style="font-family:sans-serif">
				<!-- Style Anweisung fuer body ev. noetig, weil Anpassung style.xsl durch IZ von SLSP noch offen, 20200929 -->
				<div style="max-height: 285mm; max-width: 200mm; padding: 5mm;">
					<div class="messageArea">
						<div class="messageBody">
							<!-- Adressblock -->
							<div id="top" style="position:relative; margin-top: 10mm; margin-bottom: 10mm;">
								<table width="100%">
									<tr>
										<td width="35%" align="left" valign="top">
											<i>
												<font size="2">
													<b>
														<xsl:text>Absender:</xsl:text>
													</b>
													<br/>
													<br/>
													<xsl:value-of select="notification_data/library/address/line1"/>
													<br/>
													<xsl:value-of select="notification_data/library/address/line2"/>
													<br/>
													<xsl:if test="string-length(notification_data/library/address/line3)!=0">
														<xsl:value-of select="notification_data/library/address/line3"/>
														<br/>
													</xsl:if>
													<xsl:if test="string-length(notification_data/library/address/line4)!=0">
														<xsl:value-of select="notification_data/library/address/line4"/>
														<br/>
													</xsl:if>
													<xsl:if test="string-length(notification_data/library/address/line5)!=0">
														<xsl:value-of select="notification_data/library/address/line5"/>
													</xsl:if>
													<xsl:value-of select="/notification_data/library/address/postal_code"/>&#160;<xsl:value-of select="/notification_data/library/address/city"/>
													<br/>
													<xsl:choose>
														<xsl:when test="/notification_data/partner_address/country ='CHE'">
															&#160;
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="/notification_data/library/address/country_display"/>
														</xsl:otherwise>
													</xsl:choose>
												</font>
											</i>
										</td>
										<td width="10%" align="center">
											<p>&#160;</p>
										</td>
										<td width="45%" align="left">
											<b>
													<xsl:value-of select="/notification_data/partner_address/line1"/>
													<br/>
													<xsl:value-of select="/notification_data/partner_address/line2"/>
													<br/>
													<xsl:if test="string-length(/notification_data/partner_address/line3)!=0">
														<xsl:value-of select="/notification_data/partner_address/line3"/>
														<br/>
													</xsl:if>
													<xsl:if test="string-length(/notification_data/partner_address/line4)!=0">
														<xsl:value-of select="/notification_data/partner_address/line4"/>
														<br/>
													</xsl:if>
													<xsl:if test="string-length(/notification_data/partner_address/line5)!=0">
														<xsl:value-of select="/notification_data/partner_address/line5"/>
														<br/>
													</xsl:if>
													<xsl:choose>
														<xsl:when test="/notification_data/partner_address/country !='CHE'">
															<xsl:value-of select="/notification_data/partner_address/country"/>&#160;-&#160;<xsl:value-of select="/notification_data/partner_address/postal_code"/>&#160;<xsl:value-of select="/notification_data/partner_address/city"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="/notification_data/partner_address/postal_code"/>&#160;<xsl:value-of select="/notification_data/partner_address/city"/>
															<br/>
															<xsl:value-of select="/notification_data/partner_address/country_display"/>
														</xsl:otherwise>
													</xsl:choose>
											</b>
										</td>
									</tr>
								</table>
							</div>
							<!-- Inhalt -->
							<div id="middle" style="position:relative; margin-top: 40mm; margin-bottom: 10mm;">
								<xsl:value-of select="notification_data/general_data/current_date"/>
								<p>&#160; </p>
								<b>@@letterName@@</b>
								<p>&#160; </p>
								<p>@@returned@@</p>
								<table>
									<tr>
										<td width="20%" >
											<b> @@request_id@@: </b>
										</td>
										<td>
											<img src="externalId.png" alt="externalId"/>
										</td>
									</tr>
										<tr>
											<td><br/></td>
											<td></td>
										</tr>
										<tr>
											<td><br/></td>
											<td></td>
										</tr>
									<tr>
										<td>
											<b>@@title@@: </b>
										</td>
										<td>
											<xsl:value-of select="/notification_data/request/display/title"/>
											<xsl:if test="notification_data/request/display/journal_title !=''">
												<b>@@journal_title@@: </b>
												<xsl:value-of select="notification_data/request/display/journal_title"/>
												<b>@@volume@@: </b>
												<xsl:value-of select="notification_data/request/display/volume"/>
												<b>@@issue@@: </b>
												<xsl:value-of select="notification_data/request/display/issue"/>
											</xsl:if>
										</td>
									</tr>
									<tr>
										<td>
											<b>@@author@@: </b>
										</td>
										<td>
											<xsl:value-of select="/notification_data/request/display/author"/>
										</td>
									</tr>
									<tr>
										<tr>
											<td><br/></td>
											<td></td>
										</tr>
										<td>
											<b>@@note_to_partner@@: </b>
										</td>
										<td>
											<xsl:value-of select="notification_data/note_to_partner"/>
										</td>
									</tr>
								</table>
								<!-- Abschluss mit Grussformel -->
								<p>&#160; </p>
								<p>@@signature@@</p>
								<p>
									<xsl:value-of select="notification_data/library/address/line1"/>
									<br/>
									<xsl:value-of select="notification_data/library/address/line2"/>
									<br/>
									<xsl:value-of select="/notification_data/library/address/email"/>
								</p>
							</div>
							<!-- -->
							<!-- -->
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>