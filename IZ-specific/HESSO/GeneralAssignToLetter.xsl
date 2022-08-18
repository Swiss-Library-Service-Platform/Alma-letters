<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP Customized 08/2022 -->
<!-- Dependance:
    recordTitle - SLSP-multilingual
    style - generalStyle, bodyStyleCss
    header - head -->
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
                <!-- <xsl:call-template name="senderReceiver" /> -->
                <!-- SenderReceiver.xsl -->
                <br />
                
                <!-- <xsl:call-template name="toWhomIsConcerned" /> -->
                <!-- mailReason.xsl -->
                <table cellspacing="0" cellpadding="5" border="0">
                    <tr>
                        <td>
                            <xsl:call-template name="SLSP-multilingual">
                                <xsl:with-param name="en" select="'Hello'"/>
                                <xsl:with-param name="fr" select="'Bonjour'"/>
                                <xsl:with-param name="it" select="'Buongiorno,'"/>
                                <xsl:with-param name="de" select="'Guten Tag'"/>
                            </xsl:call-template>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <br/>
					@@you_are_assign@@
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <xsl:value-of select="/notification_data/assigned_object"/><br />
                            <strong><xsl:value-of select="/notification_data/assigned_object_name"/></strong>
                        </td>
                    </tr>
                <xsl:if test="notification_data/note">
                    <tr>
                        <td>
                            <strong>@@note@@:</strong>&#160;
                            <xsl:value-of select="/notification_data/note" />
                        </td>
                    </tr>
                </xsl:if>
                    <tr>
                        <td>
                            <br/>
                            @@sincerely@@
                        </td>
                    </tr>
                    <xsl:for-each select="notification_data/owner">
                        <tr>
                            <td>
                                <xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                    <xsl:for-each select="notification_data/organization_unit">
                        <tr>
                            <td>
                                <xsl:value-of select="name"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                    <tr>
					    <td><br/><i>powered by SLSP</i></td>
				    </tr>
                </table>
                <!-- <xsl:call-template name="lastFooter" /> -->
                <!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>