<?xml version="1.0" encoding="utf-8"?>
<!-- WG:Letters 12/2022
Dependance:
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

    <xsl:template name="senderReceiver-ILL-cancel">
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
				<xsl:call-template name="head" /><!-- header.xsl -->
                <xsl:call-template name="senderReceiver-ILL-cancel" />
                <div class="messageArea">
					<div class="messageBody">
                        <table role='presentation'  cellspacing="0" cellpadding="5" border="0">
                            <xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" />
							</xsl:attribute>
                            <tr>
                                <td>
                                    @@header@@
                                </td>
                            </tr>
							<!-- <xsl:choose>
								<xsl:when test="notification_data/request/needed_by !=''">
									<tr>
										<td>
											<strong>@@requested_by@@: </strong>
											<xsl:value-of select="notification_data/request/needed_by"/>
										</td>
									</tr>
								</xsl:when>
								<xsl:otherwise>
									<tr>
										<td>
											<strong>@@requested@@</strong>
										</td>
										<td>
										    <xsl:value-of select="notification_data/request_sending_date" />
										</td>
									</tr>
								</xsl:otherwise>
							</xsl:choose> -->
                            <tr>
                                <td>
                                    @@requested@@
                                </td>
                            </tr>
                            <xsl:for-each select="notification_data/request">
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
                                        <strong>@@format@@: </strong>
                                        <xsl:value-of select="display/material_type" />
                                    </td>
                                </tr>
                                <!-- <xsl:if test="notification_data/request/display/title !=''">
                                    <tr>
                                        <td>
                                            <strong>@@title@@: </strong>
                                            <xsl:value-of select="notification_data/request/display/title" />
                                        </td>
                                    </tr>
                                </xsl:if> -->
                                <!-- <xsl:if test="notification_data/request/display/journal_title !=''">
                                    <tr>
                                        <td>
                                            <strong>@@journal_title@@: </strong>
                                            <xsl:value-of select="notification_data/request/display/journal_title" />
                                        </td>
                                    </tr>
                                </xsl:if> -->
                                <!-- <xsl:if test="notification_data/request/display/author !=''">
                                    <tr>
                                        <td>
                                            <strong>@@author@@: </strong>
                                            <xsl:value-of select="notification_data/request/display/author" />
                                        </td>
                                    </tr>
                                </xsl:if> -->
                                <!-- <xsl:if test="notification_data/request/display/autho_initials !=''">
                                    <tr>
                                        <td>
                                            <strong>@@author_initials@@: </strong>
                                            <xsl:value-of select="notification_data/request/display/autho_initials" />
                                        </td>
                                    </tr>
                                </xsl:if> -->
                                <!-- <xsl:if test="notification_data/request/display/publisher !=''">
                                    <tr>
                                        <td>
                                            <strong>@@publisher@@: </strong>
                                            <xsl:value-of select="notification_data/request/display/publisher" />
                                        </td>
                                    </tr>
                                </xsl:if> -->
                                <!-- <xsl:if test="notification_data/request/display/place_of_publication !=''">
                                    <tr>
                                        <td>
                                            <strong>@@place_of_publication@@: </strong>
                                            <xsl:value-of select="notification_data/request/display/place_of_publication" />
                                        </td>
                                    </tr>
                                </xsl:if> -->
                                <!-- <xsl:if test="notification_data/request/display/date !=''">
                                    <tr>
                                        <td>
                                            <strong>@@publication_date@@: </strong>
                                            <xsl:value-of select="notification_data/request/display/date" />
                                        </td>
                                    </tr>
                                </xsl:if> -->
                                <xsl:if test="display/year !=''">
                                    <tr>
                                        <td>
                                            <strong>@@year@@: </strong>
                                            <xsl:value-of select="display/year" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/edition !=''">
                                    <tr>
                                        <td>
                                            <strong>@@edition@@: </strong>
                                            <xsl:value-of select="display/edition" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/call_number !=''">
                                    <tr>
                                        <td>
                                            <strong>@@call_number@@: </strong>
                                            <xsl:value-of select="display/call_number" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/volume !=''">
                                    <tr>
                                        <td>
                                            <strong>@@volume@@: </strong>
                                            <xsl:value-of select="display/volume" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/issue !=''">
                                    <tr>
                                        <td>
                                            <strong>@@issue@@: </strong>
                                            <xsl:value-of select="display/issue" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/additional_person_name !=''">
                                    <tr>
                                        <td>
                                            <strong>@@additional_person_name@@: </strong>
                                            <xsl:value-of select="display/additional_person_name" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/source !=''">
                                    <tr>
                                        <td>
                                            <strong>@@source@@: </strong>
                                            <xsl:value-of select="display/source" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/series_title_number !=''">
                                    <tr>
                                        <td>
                                            <strong>@@series_title_number@@: </strong>
                                            <xsl:value-of select="display/series_title_number" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/isbn !=''">
                                    <tr>
                                        <td>
                                            <strong>@@isbn@@: </strong>
                                            <xsl:value-of select="display/isbn" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/issn !=''">
                                    <tr>
                                        <td>
                                            <strong>@@issn@@: </strong>
                                            <xsl:value-of select="display/issn" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/doi !=''">
                                    <tr>
                                        <td>
                                            <strong>@@doi@@: </strong>
                                            <xsl:value-of select="display/doi" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/pmid !=''">
                                    <tr>
                                        <td>
                                            <strong>@@pmid@@: </strong>
                                            <xsl:value-of select="display/pmid" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/note !=''">
                                    <tr>
                                        <td>
                                            <strong>@@note@@: </strong>
                                            <xsl:value-of select="display/note" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/chapter !=''">
                                    <tr>
                                        <td>
                                            <strong>@@chapter@@: </strong>
                                            <xsl:value-of select="display/chapter" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/volume_bk !=''">
                                    <tr>
                                        <td>
                                            <strong>@@volume@@: </strong>
                                            <xsl:value-of select="display/volume_bk" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/part !=''">
                                    <tr>
                                        <td>
                                            <strong>@@part@@: </strong>
                                            <xsl:value-of select="display/part" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/pages !=''">
                                    <tr>
                                        <td>
                                            <strong>@@pages@@: </strong>
                                            <xsl:value-of select="display/pages" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/start_page !=''">
                                    <tr>
                                        <td>
                                            <strong>@@start_page@@: </strong>
                                            <xsl:value-of select="display/start_page" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="display/end_page !=''">
                                    <tr>
                                        <td>
                                            <strong>@@end_page@@: </strong>
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
                                            <strong>@@request_note@@: </strong>
                                            <xsl:value-of select="note" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="/notification_data/request_sending_date != ''">
                                    <tr>
                                        <td>
                                            <strong>@@date@@: </strong>
                                            <xsl:value-of select="/notification_data/request_sending_date" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <!-- <xsl:if test="notification_data/request/external_request_id !=''">
                                    <tr>
                                        <td>
                                            <strong>@@request_id@@: </strong>
                                            <xsl:value-of select="notification_data/request/external_request_id" />
                                        </td>
                                    </tr>
                                </xsl:if> -->
                                <xsl:if test="format_display != ''">
                                    <tr>
                                        <td>
                                            <strong>@@request_format@@: </strong>
                                            <xsl:value-of select="format_display" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="/notification_data/note_to_partner != ''">
                                    <tr>
                                        <td>
                                            <strong>@@note_to_partner@@: </strong>
                                            <xsl:value-of select="/notification_data/note_to_partner" />
                                        </td>
                                    </tr>
                                </xsl:if>
                                <xsl:if test="max_fee !=''">
									<tr>
										<td>
											<b>@@maximum_fee@@: </b>
											<xsl:value-of select="max_fee"/>
										</td>
									</tr>
								</xsl:if>
                            </xsl:for-each>
							<tr>
								<td>
                                    <br />
                                    @@signature@@
                                </td>
							</tr>
                            <tr>
                                <td>
                                    <xsl:value-of select="/notification_data/library/name"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br/>
                                    <i>powered by SLSP</i>
                                </td>
                            </tr>
						</table>
					</div>
				</div>
				<!-- <xsl:call-template name="lastFooter" /> -->
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
