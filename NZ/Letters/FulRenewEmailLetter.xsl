<?xml version="1.0" encoding="utf-8"?>
<!-- WG: Letters 04/2024 -->
<!-- Dependance:
    header - head
    style - generalStyle, bodyStyleCss, mainTableStyleCss
    recordTitle - -->
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
                <!-- sender -->
                <td width="50%" align="left" style="padding: 10mm 10mm 10mm 10mm;">
                    <xsl:choose>
                        <xsl:when test="notification_data/request/line1 != ''">
                            <xsl:for-each select="notification_data/request">
                                <table>
                                    <xsl:attribute name="style">
										font-size: 9pt;
                                        <xsl:call-template name="listStyleCss" />
                                        <!-- style.xsl -->
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
										font-size: 9pt;
                                        <xsl:call-template name="listStyleCss" />
                                        <!-- style.xsl -->
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
                                                <xsl:value-of select="address/country_display"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="string-length(phone/phone)!=0">
                                        <tr>
                                            <td>
                                                <xsl:value-of select="phone/phone"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="string-length(email/email)!=0">
                                        <tr>
                                            <td>
                                                <xsl:value-of select="email/email"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </table>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
                <!-- receiver -->
                <td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm; vertical-align: top;">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <xsl:attribute name="style">
							font-weight: 600;font-size: 10pt;
                            <xsl:call-template name="listStyleCss" />
                            <!-- style.xsl -->
                        </xsl:attribute>
                        <xsl:if test="string-length(notification_data/partner_address/line1)!=0">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line1"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="string-length(notification_data/partner_address/line2)!=0">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line2"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="string-length(notification_data/partner_address/line3)!=0">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line3"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="string-length(notification_data/partner_address/line4)!=0">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line4"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="string-length(notification_data/partner_address/line5)!=0">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line5"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/partner_address/postal_code != '' or notification_data/partner_address/city != ''">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/postal_code"/>&#160;<xsl:value-of select="notification_data/partner_address/city"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/partner_address/country_display != ''">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/country_display"/>
                                </td>
                            </tr>
                        </xsl:if>
                    </table>
                </td>
            </tr>
        </table>
        <br/>
    </xsl:template>

    <!--Fix to transform the note coming from Alma UI to insert new lines
		Takes the parameter text and replaces new lines with <br/> 
	Source: https://stackoverflow.com/questions/561235/xslt-replace-n-with-br-only-in-one-node
		@Tomalak, CC-BY-SA 3.0
	-->
	<xsl:template name="break">
		<xsl:param name="text" select="string(.)"/>
		<xsl:choose>
			<xsl:when test="contains($text, '&#xa;')">
			<xsl:value-of select="substring-before($text, '&#xa;')"/>
			<br/>
			<xsl:call-template name="break">
				<xsl:with-param 
				name="text" 
				select="substring-after($text, '&#xa;')"
				/>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
			<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

    <xsl:template match="/">
        <html>
            <head>
                <xsl:call-template name="generalStyle" />
            </head>
            <body>
                <xsl:attribute name="style">
                    <xsl:call-template name="bodyStyleCss" />;font-size: 100%;
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
                                        <xsl:if test="desired_due_date != ''">
                                            @@desired_due_date@@&#160;<xsl:value-of select="desired_due_date" />.
                                        </xsl:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <xsl:if test="display/journal_title !=''">
                                            <strong>
                                                <xsl:value-of select="display/journal_title" />: </strong>
                                        </xsl:if>
                                        <xsl:if test="display/title !=''">
                                            <strong>
                                                <xsl:value-of select="display/title" />
                                            </strong>
                                        </xsl:if>
                                        <xsl:if test="display/author !=''">
                                            <br />
                                            <xsl:value-of select="display/author" />
                                        </xsl:if>
                                        <xsl:if test="display/autho_initials !=''">
                                            <br />
                                            <xsl:value-of select="display/autho_initials" />
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
                                        <strong>@@format@@: </strong><xsl:value-of select="display/material_type" />
                                        <xsl:if test="display/year !=''">
                                            <br/><strong>@@year@@: </strong><xsl:value-of select="display/year" />
                                        </xsl:if>
                                        <xsl:if test="display/edition !=''">
                                            <br/><strong>@@edition@@: </strong><xsl:value-of select="display/edition" />
                                        </xsl:if>
                                        <xsl:if test="display/call_number !=''">
                                            <br/><strong>@@call_number@@: </strong><xsl:value-of select="display/call_number" />
                                        </xsl:if>
                                        <xsl:if test="display/volume !=''">
                                            <br/><strong>@@volume@@: </strong><xsl:value-of select="display/volume" />
                                        </xsl:if>
                                        <xsl:if test="display/issue !=''">
                                            <br/><strong>@@issue@@: </strong><xsl:value-of select="display/issue" />
                                        </xsl:if>
                                        <xsl:if test="display/additional_person_name !=''">
                                            <br/><strong>@@additional_person_name@@: </strong><xsl:value-of select="display/additional_person_name" />
                                        </xsl:if>
                                        <xsl:if test="display/source !=''">
                                            <br/><strong>@@source@@: </strong><xsl:value-of select="display/source" />
                                        </xsl:if>
                                        <xsl:if test="display/series_title_number !=''">
                                            <br/><strong>@@series_title_number@@: </strong><xsl:value-of select="display/series_title_number" />
                                        </xsl:if>
                                        <xsl:if test="display/isbn !=''">
                                            <br/><strong>@@isbn@@: </strong><xsl:value-of select="display/isbn" />
                                        </xsl:if>
                                        <xsl:if test="display/issn !=''">
                                            <br/><strong>@@issn@@: </strong><xsl:value-of select="display/issn" />
                                        </xsl:if>
                                        <xsl:if test="display/doi !=''">
                                            <br/><strong>@@doi@@: </strong><xsl:value-of select="display/doi" />
                                        </xsl:if>
                                        <xsl:if test="display/pmid !=''">
                                            <br/><strong>@@pmid@@: </strong><xsl:value-of select="display/pmid" />
                                        </xsl:if>
                                        <xsl:if test="display/note !=''">
                                            <br/><strong>@@note@@: </strong><xsl:value-of select="display/note" />
                                        </xsl:if>
                                        <xsl:if test="display/chapter !=''">
                                            <br/><strong>@@chapter@@: </strong><xsl:value-of select="display/chapter" />
                                        </xsl:if>
                                        <xsl:if test="display/volume_bk !=''">
                                            <br/><strong>@@volume@@: </strong><xsl:value-of select="display/volume_bk" />
                                        </xsl:if>
                                        <xsl:if test="display/part !=''">
                                            <br/><strong>@@part@@: </strong><xsl:value-of select="display/part" />
                                        </xsl:if>
                                        <xsl:if test="display/pages !=''">
                                            <br/><strong>@@pages@@: </strong><xsl:value-of select="display/pages" />
                                        </xsl:if>
                                        <xsl:if test="display/start_page !=''">
                                            <br/><strong>@@start_page@@: </strong><xsl:value-of select="display/start_page" />
                                        </xsl:if>
                                        <xsl:if test="display/end_page !=''">
                                            <br/><strong>@@end_page@@: </strong><xsl:value-of select="display/end_page" />
                                        </xsl:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <!-- Empty line before printing request info -->
                                        <br />
                                        <strong>@@request_id@@: </strong>
                                        <xsl:value-of select="external_request_id" />
                                        <xsl:if test="needed_by !=''">
                                            <br/><strong>@@requested_by@@: </strong><xsl:value-of select="needed_by"/>
                                        </xsl:if>
                                        <xsl:if test="due_date !=''">
                                            <br/><strong>@@original_due_date@@: </strong><xsl:value-of select="due_date" />
                                        </xsl:if>
                                        <xsl:if test="format_display !=''">
                                            <br/><strong>@@request_format@@: </strong><xsl:value-of select="format_display" />
                                        </xsl:if>
                                        <xsl:if test="note !=''">
                                            <br/><strong>@@request_note@@: </strong>
                                            <xsl:call-template name="break">
                                                <xsl:with-param name="text" select="note"/>
                                            </xsl:call-template>
                                        </xsl:if>
                                        <xsl:if test="item_arrival_date !=''">
                                            <br/><strong>@@receiving_date@@: </strong><xsl:value-of select="item_arrival_date" />
                                        </xsl:if>
                                        <xsl:if test="/notification_data/note_to_partner !=''">
                                            <br/><strong>@@note_to_partner@@: </strong><xsl:value-of select="/notification_data/note_to_partner" />
                                        </xsl:if>
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
