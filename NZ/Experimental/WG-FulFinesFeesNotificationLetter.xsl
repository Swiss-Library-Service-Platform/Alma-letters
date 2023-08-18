<?xml version="1.0" encoding="utf-8"?>
<!-- WG:Letters 03/2023 -->
<!-- Dependance:
    header - head
    senderReceiver - senderReceiver
    style - generalStyle, bodyStyleCss, mainTableStyleCss -->
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
            <xsl:call-template name="bodyStyleCss" />;font-size: 100%;
        </xsl:attribute>

            <xsl:call-template name="head" /> <!-- header.xsl -->
            <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
            <span>
                @@dear@@
            </span>
            <p>
                @@we_would_like@@<strong></strong>
            </p>

            <table role='presentation' cellpadding="5" class="listing">
            <xsl:attribute name="style">
                <xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
            </xsl:attribute>
                <tr>
                    <th><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                        <xsl:with-param name="en" select="'Date'"/>
                        <xsl:with-param name="fr" select="'Date'"/>
                        <xsl:with-param name="it" select="'Data'"/>
                        <xsl:with-param name="de" select="'Datum'"/>
                    </xsl:call-template></th>
                    <th>@@fee_type@@</th>
                    <th>@@note@@</th>
                    <th>@@fee_amount@@</th>
                    
                </tr>
                <xsl:for-each select="notification_data/fines_fees_list/user_fines_fees">
                <tr>
                    <td><xsl:value-of select="create_date"/></td>
                    <td><xsl:value-of select="fine_fee_type_display"/></td>
                    <td><xsl:value-of select="fine_comment"/></td>
                    <td><xsl:value-of select="fine_fee_ammount/currency"/>&#160;<xsl:value-of select="fine_fee_ammount/normalized_sum"/></td>
                </tr>
                </xsl:for-each>
                <tr>
                    <td colspan="3">
                        <strong>@@debt_of@@</strong>
                    </td>
                    <td>
                        <xsl:value-of select="notification_data/total_fines_currency"/>&#160;<xsl:value-of select="notification_data/total_fines_amount"/>
                    </td>
                </tr>
                <!-- SLSP does not use notification fees 
                    <xsl:if test="notification_data/fine_fee_notification_fee_amount/sum !=''">
                    <tr>
                        <td>
                            <strong>@@fine_fee_notification_fee@@ </strong>
                        </td>
                        <td>
                            <xsl:value-of select="notification_data/fine_fee_notification_fee_amount/normalized_sum"/>&#160;<xsl:value-of select="notification_data/fine_fee_notification_fee_amount/currency"/>&#160;<xsl:value-of select="ff"/>
                        </td>
                    </tr>
                </xsl:if> -->
            </table>
            <p>
                <xsl:call-template name="SLSP-userAccount"/>
            </p>
            <p>@@sincerely@@</p>
            <p><xsl:value-of select="notification_data/organization_unit/name"/></p>
            <br/>
            <p>
                <i>powered by SLSP</i>
            </p>
            <!-- <xsl:call-template name="lastFooter" /> --> <!-- footer.xsl -->
        </body>
	</html>
</xsl:template>

</xsl:stylesheet>