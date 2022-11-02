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

	<xsl:template name="senderReceiver-ILL-outgoing">
		<!-- Adapted by SLSP - delivery address on right
		- Fixed padding for envelopes with window
		- Delivery address bold
		- Sender address smaller font -->
		<table cellspacing="0" cellpadding="5" border="0" width="100%">
			<tr>
				<td width="50%" align="left" style="padding: 10mm 10mm 10mm 10mm;">
					<xsl:choose>
						<xsl:when test="notification_data/request/line1 != ''">
							<xsl:for-each select="notification_data/request">
								<table>
									<xsl:attribute name="style">
										font-size: 80%;
										<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
									</xsl:attribute>
									<tr>
										<td>
											<xsl:value-of select="line1" />
										</td>
									</tr>
									<xsl:if test="line2 !=''">
										<tr>
											<td>
												<xsl:value-of select="line2" />
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="line3 !=''">
										<tr>
											<td>
												<xsl:value-of select="line3" />
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="line4 !=''">
										<tr>
											<td>
												<xsl:value-of select="line4" />
											</td>
										</tr>
									</xsl:if>
								</table>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="notification_data/library">
								<table>
									<xsl:attribute name="style">
										font-size: 80%;
										<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
									</xsl:attribute>
									<xsl:if test="address/line1 !=''">
										<tr>
											<td>
												<xsl:value-of select="address/line1" />
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="address/line2 !=''">
										<tr>
											<td>
												<xsl:value-of select="address/line2" />
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="address/line3 !=''">
										<tr>
											<td>
												<xsl:value-of select="address/line3" />
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="address/line4 !=''">
										<tr>
											<td>
												<xsl:value-of select="address/line4" />
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="address/line5 !=''">
										<tr>
											<td>
												<xsl:value-of select="address/line5" />
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="address/city !=''">
										<tr>
											<td>
												<xsl:value-of select="address/postal_code" />&#160;<xsl:value-of select="address/city" />
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="address/country_display != ''">
										<tr>
											<td>
												<xsl:value-of select="naddress/country_display"/>
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="string-length(phone/phone)!=0">
										<tr><td><xsl:value-of select="phone/phone"/></td></tr>
									</xsl:if>
									<xsl:if test="string-length(email/email)!=0">
										<tr><td><xsl:value-of select="email/email"/></td></tr>
									</xsl:if>
								</table>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
				</td>
				<td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm; vertical-align: top;">
					<table cellspacing="0" cellpadding="0" border="0">
						<xsl:attribute name="style">
							font-weight: 600;
							<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
						<xsl:if test="string-length(notification_data/partner_address/line1)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line1"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(notification_data/partner_address/line2)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line2"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(notification_data/partner_address/line3)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line3"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(notification_data/partner_address/line4)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line4"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(notification_data/partner_address/line5)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line5"/></td></tr>
						</xsl:if>
						<tr><td><xsl:value-of select="notification_data/partner_address/postal_code"/>&#160;<xsl:value-of select="notification_data/partner_address/city"/></td></tr>
						<tr><td>
							<xsl:value-of select="notification_data/partner_address/country_display"/>
						</td></tr>
					</table>
				</td>
			</tr>
		</table>
		<br/>
	</xsl:template>

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
				<xsl:call-template name="senderReceiver-ILL-outgoing" />
				<div class="messageArea">
					<div class="messageBody">
						<table cellspacing="0" cellpadding="5" border="0">
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" />
								<!-- style.xsl -->
							</xsl:attribute>
							<xsl:for-each select="notification_data/request">
								<tr>
									<td>
										@@header@@
									</td>
								</tr>
								<tr>
									<td>
										@@requested@@
									</td>
								</tr>
								<tr>
									<td>
										<br />
										<xsl:if test="display/journal_title !=''">
											<strong><xsl:value-of select="display/journal_title" />: </strong>
										</xsl:if>
										<xsl:if test="display/title !=''">
											<strong><xsl:value-of select="display/title" /></strong>
										</xsl:if>
										<xsl:if test="display/author !=''">
											<br /><xsl:value-of select="display/author" />
										</xsl:if>
										<xsl:if test="display/autho_initials !=''">
											<br /><xsl:value-of select="display/autho_initials" />
										</xsl:if>
										<!-- Logic to display the imprint correctly -->
										<xsl:if test="display/publisher or display/place_of_publication or display/publication_date">
											<br />
											<xsl:if test="display/publisher !=''">
												<xsl:value-of select="display/publisher" />
											</xsl:if>
											<xsl:if test="display/place_of_publication !=''">
												<xsl:if test="display/publisher !=''">:&#160;</xsl:if>
												<xsl:value-of select="display/place_of_publication" />
											</xsl:if>
											<xsl:if test="display/publication_date !=''">
												<xsl:if test="display/publisher !='' or display/place_of_publication !=''">,&#160;</xsl:if>
												<xsl:value-of select="display/publication_date" />
											</xsl:if>
										</xsl:if>
									</td>
								</tr>
								<tr>
									<td>
										<b>@@format@@: </b>
										<xsl:value-of select="display/material_type" />
									</td>
								</tr>
								<xsl:if test="display/year !=''">
									<tr>
										<td>
											<b>@@year@@: </b>
											<xsl:value-of select="display/year" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/edition !=''">
									<tr>
										<td>
											<b>@@edition@@: </b>
											<xsl:value-of select="display/edition" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/call_number !=''">
									<tr>
										<td>
											<b>@@call_number@@: </b>
											<xsl:value-of select="display/call_number" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/volume !=''">
									<tr>
										<td>
											<b>@@volume@@: </b>
											<xsl:value-of select="display/volume" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/issue !=''">
									<tr>
										<td>
											<b>@@issue@@: </b>
											<xsl:value-of select="display/issue" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/additional_person_name !=''">
									<tr>
										<td>
											<b>@@additional_person_name@@: </b>
											<xsl:value-of select="display/additional_person_name" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/source !=''">
									<tr>
										<td>
											<b>@@source@@: </b>
											<xsl:value-of select="display/source" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/series_title_number !=''">
									<tr>
										<td>
											<b>@@series_title_number@@: </b>
											<xsl:value-of select="display/series_title_number" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/isbn !=''">
									<tr>
										<td>
											<b>@@isbn@@: </b>
											<xsl:value-of select="display/isbn" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/issn !=''">
									<tr>
										<td>
											<b>@@issn@@: </b>
											<xsl:value-of select="display/issn" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/doi !=''">
									<tr>
										<td>
											<b>@@doi@@: </b>
											<xsl:value-of select="display/doi" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/pmid !=''">
									<tr>
										<td>
											<b>@@pmid@@: </b>
											<xsl:value-of select="display/pmid" />
										</td>
									</tr>
								</xsl:if>
								<!-- Hardcoded note label so it can be used for IZ message -->
								<xsl:if test="display/note !=''">
									<tr>
										<td>
											<b><xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Note'"/>
												<xsl:with-param name="fr">
													<![CDATA[Note]]>
												</xsl:with-param>
												<xsl:with-param name="it" select="'Nota'"/>
												<xsl:with-param name="de" select="'Notiz'"/>
											</xsl:call-template>: </b>
											<xsl:value-of select="display/note" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/chapter !=''">
									<tr>
										<td>
											<b>@@chapter@@: </b>
											<xsl:value-of select="display/chapter" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/volume_bk !=''">
									<tr>
										<td>
											<b>@@volume@@: </b>
											<xsl:value-of select="display/volume_bk" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/part !=''">
									<tr>
										<td>
											<b>@@part@@: </b>
											<xsl:value-of select="display/part" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/pages !=''">
									<tr>
										<td>
											<b>@@pages@@: </b>
											<xsl:value-of select="display/pages" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/start_page !=''">
									<tr>
										<td>
											<b>@@start_page@@: </b>
											<xsl:value-of select="display/start_page" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="display/end_page !=''">
									<tr>
										<td>
											<b>@@end_page@@: </b>
											<xsl:value-of select="display/end_page" />
										</td>
									</tr>
								</xsl:if>
								<!-- Empty line between printing request info -->
								<tr>
									<td>
										&#160;<br />
									</td>
								</tr>
								<xsl:if test="external_request_id !=''">
									<tr>
										<td>
											<b>@@request_id@@: </b>
											<xsl:value-of select="external_request_id" />
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="needed_by !=''">
									<tr>
										<td>
											<b>@@requested_by@@: </b>
											<xsl:value-of select="needed_by"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="note !=''">
									<tr>
										<td>
											<b>@@request_note@@: </b>
											<xsl:value-of select="note" />
										</td>
									</tr>
								</xsl:if>
								<tr>
									<td>
										<b>@@request_format@@: </b>
										<xsl:value-of select="format_display" />
									</td>
								</tr>
								<xsl:if test="max_fee !=''">
									<tr>
										<td>
											<b>@@maximum_fee@@: </b>
											<xsl:value-of select="max_fee"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="/notification_data/level_of_service !=''">
									<tr>
										<td>
											<b>@@level_of_service@@: </b>
											<xsl:value-of select="/notification_data/level_of_service"/>
										</td>
									</tr>
								</xsl:if>
								<!-- reusing the label note for IZ specific information within the letter 
										the text may contain HTML markup, i.e. links
								-->
								<xsl:variable name="IZnotice">@@note@@</xsl:variable>
								<xsl:if test="$IZnotice != '' and $IZnotice != 'blank'">
									<tr>
										<td>
											<br />
											@@note@@
										</td>
									</tr>
								</xsl:if>
								<tr>
									<td>
										<br />
										@@signature@@
									</td>
								</tr>
								<tr>
									<td>
										<xsl:value-of select="/notification_data/library/name"/><br />
									</td>
								</tr>
								<tr>
									<td>
										<br/>
										<i>powered by SLSP</i>
									</td>
								</tr>
							</xsl:for-each>
						</table>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>