<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 10/2023 -->
<!-- Dependance:
    header - head
    style - generalStyle, bodyStyleCss, mainTableStyleCss
    recordTitle - SLSP-greeting, SLSP-multilingual -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

<!-- Prints the IZ message stored in label 'department' for the language of the letter.
		If value in the label is empty or with value "blank" does not print anything.
		The label can contain also HTML markup such as links or formatting.
		Usage:
			1. Configure the label department with text in all languages.
			2. <<already done by SLSP in this letter>>Insert the template: <xsl:call-template name="SLSP-IZMessage"/> -->
<xsl:template name="SLSP-IZMessage">
	<xsl:variable name="notice">@@department@@</xsl:variable>
	<xsl:if test="$notice != '' and $notice != 'blank'">
		<strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
			<xsl:with-param name="en" select="'Notice of the library'"/>
			<xsl:with-param name="fr" select="'Avis de la bibliothèque'"/>
			<xsl:with-param name="it" select="'Comunicazione della biblioteca'"/>
			<xsl:with-param name="de" select="'Notiz der Bibliothek'"/>
		</xsl:call-template>:</strong>&#160;<xsl:value-of select="$notice" disable-output-escaping="yes" />
	</xsl:if>
</xsl:template>

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
      </head>
      <body>
        <xsl:attribute name="style">
          <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head" /><!-- header.xsl -->
        <xsl:if test="/notification_data/user_for_printing/user_group = '92'">
            <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
        </xsl:if>
        <div class="messageArea">
          <div class="messageBody">

            <table role='presentation' cellspacing="0" cellpadding="5" border="0">  
                <!-- New feature for displaying user group 92 information -->
                <xsl:for-each select="notification_data/receivers/receiver/user">
                    <tr>
                        <td>
                            <br />
                            <xsl:if test="user_group = '92'">
                                <strong>
                                    <xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                        <xsl:with-param name="en" select="'Special user cantonal library'"/>
                                        <xsl:with-param name="fr" select="'Utilisateur spécial bibliothèque cantonale'"/>
                                        <xsl:with-param name="it" select="'Utente speciale biblioteca cantonale'"/>
                                        <xsl:with-param name="de" select="'Spezialnutzende Kantonsbibliothek'"/>
                                    </xsl:call-template>
                                </strong><br />
                            </xsl:if>
                            <xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/><br />
                            <!-- set the barcode values in variables -->
                            <!-- set the Barcode NZ, if there are more then only first one is returned -->
                            <xsl:variable name="NZ_barcode">
                                <xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='02']/value"/>
                            </xsl:variable>
                            <!-- set the Barcode edu-ID, if there are more then only first one is returned -->
                            <xsl:variable name="edu-id_barcode">
                                <xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='01']/value"/>
                            </xsl:variable>
                            <!-- set the Barcode IZ, if there are more then only first one is returned -->
                            <xsl:variable name="IZ_barcode">
                                <xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='03']/value"/>
                            </xsl:variable>
                            <!-- set the barcode values in variables -->

                            <xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                <xsl:with-param name="en" select="'User ID'"/>
                                <xsl:with-param name="fr" select="'ID utilisateur'"/>
                                <xsl:with-param name="it" select="'ID utente'"/>
                                <xsl:with-param name="de" select="'Benutzer-ID'"/>
                            </xsl:call-template>: 
                            <xsl:choose>
                                <xsl:when test="$edu-id_barcode != ''">
                                    <xsl:value-of select="$edu-id_barcode"/><br />
                                </xsl:when>
                                <xsl:when test="$NZ_barcode != ''">
                                    <xsl:value-of select="$NZ_barcode"/><br />
                                </xsl:when>
                                <xsl:when test="$IZ_barcode != ''">
                                    <xsl:value-of select="$IZ_barcode"/><br />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='Primary Identifier']/value"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </td>
                    </tr>
                </xsl:for-each>
                <tr>
                    <td>
                        <br />
                        <xsl:call-template name="SLSP-greeting" />
                    </td>
                </tr>
                <tr>
                    <td>
                        @@following_items_awaiting_pickup@@
                    </td>
                </tr>
                <xsl:for-each select="/notification_data/requests_by_library/library_requests_for_display">
                    <tr>
                        <td>
                            <table cellpadding="5" class="listing" width="100%">
                                <xsl:attribute name="style">
                                    <xsl:call-template name="mainTableStyleCss" />
                                </xsl:attribute>
                                <tr align="left" bgcolor="#f5f5f5">
                                    <td colspan ="2" style="padding-left:20">
                                        <h3><xsl:value-of select="organization_unit/name" /></h3>
                                        <xsl:if test="organization_unit/address/line1 != ''">
                                            <xsl:value-of select="organization_unit/address/line1"/><br/>
                                        </xsl:if>
                                        <xsl:if test="organization_unit/address/line2 != ''">
                                            <xsl:value-of select="organization_unit/address/line2"/><br/>
                                        </xsl:if>                                                
                                        <xsl:if test="organization_unit/address/line3 != ''">
                                            <xsl:value-of select="organization_unit/address/line3"/><br/> 
                                        </xsl:if>
                                        <xsl:if test="organization_unit/address/line4 != ''">
                                            <xsl:value-of select="organization_unit/address/line4"/><br/>
                                        </xsl:if>
                                        <xsl:if test="organization_unit/address/postal_code != '' or organization_unit/address/city != ''">
                                            <xsl:value-of select="organization_unit/address/postal_code"/>&#160;<xsl:value-of select="organization_unit/address/city"/><br/>
                                        </xsl:if>
                                        <xsl:if test="organization_unit/phone != ''">
                                            <xsl:value-of select="organization_unit/phone/phone"/><br/> 
                                        </xsl:if>
                                        <xsl:if test="organization_unit/email != ''">
                                            <xsl:value-of select="organization_unit/email/email"/>
                                        </xsl:if>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" width="70%">@@title@@</th>
                                    <th align="left">@@note_item_held_until@@</th>
                                </tr>

                                <xsl:for-each select="requests/request_for_display">
                                    <tr>
                                        <td>
                                            <strong><xsl:value-of select="substring(phys_item_display/title, 0, 100)"/>
                                            <xsl:if test="string-length(phys_item_display/title) > 100">...</xsl:if></strong>
                                            <xsl:if test="phys_item_display/author != ''">
                                                <br /><xsl:value-of select="phys_item_display/author"/>
                                            </xsl:if>
                                            <!-- Logic to display the imprint correctly -->
                                            <xsl:if test="phys_item_display/publisher or phys_item_display/publication_place or phys_item_display/publication_date">
                                                <br />
                                                <xsl:if test="phys_item_display/publisher !=''">
                                                    <xsl:value-of select="phys_item_display/publisher" />
                                                </xsl:if>
                                                <xsl:if test="phys_item_display/publication_place !=''">
                                                    <xsl:if test="phys_item_display/publisher !=''">:&#160;</xsl:if>
                                                    <xsl:value-of select="phys_item_display/publication_place" />
                                                </xsl:if>
                                                <xsl:if test="phys_item_display/publication_date !=''">
                                                    <xsl:if test="phys_item_display/publisher !='' or phys_item_display/publication_place !=''">,&#160;</xsl:if>
                                                    <xsl:value-of select="phys_item_display/publication_date" />
                                                </xsl:if>
                                            </xsl:if>
                                            <xsl:choose>
                                                <xsl:when test="phys_item_display/display_alt_call_numbers != ''">
                                                    <br/><strong>@@call_number@@: </strong><xsl:value-of select="phys_item_display/display_alt_call_numbers"/>
                                                </xsl:when>
                                                <xsl:when test="phys_item_display/call_number != ''">
                                                    <br/><strong>@@call_number@@: </strong><xsl:value-of select="phys_item_display/call_number"/>
                                                </xsl:when>
                                            </xsl:choose>
                                        </td>
                                        <td><xsl:value-of select="request/work_flow_entity/expiration_date"/></td>
                                    </tr>
                                </xsl:for-each>
                            </table>
                        </td>
                    </tr>
                    <br/>
                </xsl:for-each>
                <tr>
                    <td>
                        @@circulation_desk@@
                    </td>
                </tr>
                <xsl:if test="notification_data/out_of_institution_requests/request_for_display">
                    <tr>
                        <td>
                            <table cellpadding="5" class="listing">
                                <xsl:attribute name="style">
                                    <xsl:call-template name="mainTableStyleCss" />
                                </xsl:attribute>
                                <tr align="center" bgcolor="#f5f5f5">
                                    <td colspan="4">
                                        <h3>@@other_institutions@@</h3>
                                    </td>
                                </tr>
                                <tr>
                                    <th>@@title@@</th>
                                    <th>@@author@@</th>
                                    <th>@@can_picked_at@@</th>
                                    <th>@@note_item_held_until@@</th>
                                </tr>

                                <xsl:for-each select="notification_data/out_of_institution_requests/request_for_display">
                                    <tr>
                                        <td><xsl:value-of select="phys_item_display/title"/></td>
                                        <td><xsl:value-of select="phys_item_display/author"/></td>
                                        <td><xsl:value-of select="request/assigned_unit_name"/></td>
                                        <td><xsl:value-of select="request/work_flow_entity/expiration_date"/></td>
                                    </tr>
                                </xsl:for-each>
                            </table>
                        </td>
                    </tr>
                    <br/>
                </xsl:if>
                <xsl:if test="/notification_data/user_for_printing/blocks != ''">
                    <tr>
                        <td><b>@@notes_affect_loan@@:</b></td>
                    </tr>
                    <tr>
                        <td><xsl:value-of select="/notification_data/user_for_printing/blocks"/></td>
                    </tr>
                </xsl:if>
                <tr>
                    <td>
                        <xsl:call-template name="SLSP-IZMessage"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <xsl:call-template name="SLSP-userAccount"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />@@sincerely@@
                    </td>
                </tr>
                <tr>
                    <td>
                        <xsl:value-of select="/notification_data/organization_unit/name" />
                    </td>
                </tr>
                <tr>
                    <td><br /><i>powered by SLSP</i></td>
                </tr>
            </table>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>