<!--  sytle.xsl - 20201009, SLSP- non-standard  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings" version="1.0">
    <xsl:include href="header.xsl"/>
    <xsl:include href="senderReceiver.xsl"/>
    <xsl:include href="footer.xsl"/>
    <xsl:include href="style.xsl"/>
    <xsl:include href="mailReason.xsl"/>
    <xsl:include href="recordTitle.xsl"/>
    <xsl:template match="/">
        <html>
            <head>
                <xsl:call-template name="generalStyle"/>
            </head>
            <body>
                <xsl:attribute name="style">
                    <xsl:call-template name="bodyStyleCss"/>
                    <!--  style.xsl  -->
                </xsl:attribute>
                <xsl:call-template name="head"/>
                <!--  header.xsl  -->
                <div class="messageArea">
                    <div class="messageBody">
                        <br/>
                        <table cellspacing="0" cellpadding="30" border="0" width="100%">
                            <tr>
                                <td width="50%" align="left">
                                    <xsl:choose>
                                        <xsl:when test="notification_data/user_for_printing">
                                            <table cellspacing="0" cellpadding="0" border="0">
                                                <xsl:attribute name="style">
                                                    <xsl:call-template name="listStyleCss"/>
                                                    <!--  style.xsl  -->
                                                </xsl:attribute>
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="notification_data/user_for_printing/first_name"/>
                                                        <xsl:text> </xsl:text>
                                                        <xsl:value-of select="notification_data/user_for_printing/last_name"/>
                                                    </td>
                                                </tr>
                                                <xsl:if test="count(str:tokenize(notification_data/delivery_address,' '))>4">
                                                    <tr>
                                                        <td>
                                                            <xsl:value-of select="substring-after(str:tokenize(notification_data/delivery_address,' ')[2],':')"/>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="str:tokenize(notification_data/delivery_address,' ')[3]"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="count(str:tokenize(notification_data/delivery_address,' '))>6">
                                                    <tr>
                                                        <td>
                                                            <xsl:value-of select="str:tokenize(notification_data/delivery_address,' ')[4]"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="count(str:tokenize(notification_data/delivery_address,' '))>7">
                                                    <tr>
                                                        <td>
                                                            <xsl:value-of select="str:tokenize(notification_data/delivery_address,' ')[5]"/>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <tr>
                                                    <td>
                                                        <xsl:variable name="number_code" select="count(str:tokenize(notification_data/delivery_address,' '))-1"/>
                                                        <xsl:variable name="number_city" select="count(str:tokenize(notification_data/delivery_address,' '))-2"/>
                                                        <xsl:value-of select="str:tokenize(notification_data/delivery_address,' ')[$number_code]"/>
                                                        <xsl:value-of select="str:tokenize(notification_data/delivery_address,' ')[$number_city]"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <xsl:variable name="number_country" select="count(str:tokenize(notification_data/delivery_address,' '))"/>
                                                        <xsl:if test="str:tokenize(notification_data/delivery_address,' ')[$number_country]!=' CHE'">
                                                            <xsl:value-of select="str:tokenize(notification_data/delivery_address,' ')[$number_country]"/>
                                                        </xsl:if>
                                                    </td>
                                                </tr>
                                            </table>
                                        </xsl:when>
                                        <xsl:when test="notification_data/receivers/receiver/user">
                                            <xsl:for-each select="notification_data/receivers/receiver/user">
                                                <table>
                                                    <xsl:attribute name="style">
                                                        <xsl:call-template name="listStyleCss"/>
                                                        <!--  style.xsl  -->
                                                    </xsl:attribute>
                                                    <tr>
                                                        <td>
                                                            <xsl:value-of select="first_name"/>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="last_name"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <xsl:value-of select="substring-after(user_address_list/user_address/line1, ':')"/>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="user_address_list/user_address/line2"/>
                                                        </td>
                                                    </tr>
                                                    <xsl:if test="string-length(user_address_list/user_address/line3)!=0">
                                                        <tr>
                                                            <td>
                                                                <xsl:value-of select="user_address_list/user_address/line3"/>
                                                            </td>
                                                        </tr>
                                                    </xsl:if>
                                                    <xsl:if test="string-length(user_address_list/user_address/line4)!=0">
                                                        <tr>
                                                            <td>
                                                                <xsl:value-of select="user_address_list/user_address/line4"/>
                                                            </td>
                                                        </tr>
                                                    </xsl:if>
                                                    <tr>
                                                        <td>
                                                            <xsl:value-of select="user_address_list/user_address/postal_code"/>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="user_address_list/user_address/city"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <xsl:choose>
                                                                <xsl:when test="user_address_list/user_address/country = 'Null'">
                                                                    <xsl:text> </xsl:text>
                                                                </xsl:when>
                                                                <xsl:when test="user_address_list/user_address/country = 'CHE'">
                                                                    <xsl:text> </xsl:text>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:value-of select="user_address_list/user_address/country"/>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:otherwise> </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                <td width="50%" align="right">
                                    <xsl:for-each select="notification_data/organization_unit">
                                        <table>
                                            <xsl:attribute name="style">
                                                <xsl:call-template name="listStyleCss"/>
                                                <!--  style.xsl  -->
                                            </xsl:attribute>
                                            <tr>
                                                <td>
                                                    <xsl:value-of select="name"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <xsl:value-of select="address/line1"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <xsl:value-of select="address/line2"/>
                                                </td>
                                            </tr>
                                            <xsl:if test="string-length(address/line3)!=0">
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="address/line3"/>
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="string-length(address/line4)!=0">
                                                <tr>
                                                    <td>
                                                        <xsl:value-of select="address/line4"/>
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <tr>
                                                <td>
                                                    <xsl:value-of select="address/postal_code"/>
                                                    <xsl:value-of select="address/city"/>
                                                </td>
                                            </tr>
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
                                </td>
                            </tr>
                        </table>
                        <br/>
                        <br/>
                        <table cellspacing="0" cellpadding="5" border="0">
                            <tr>
                                <td>
                                    <br/>
                                    <br/>
@@we_sent@@
                                    <xsl:value-of select="notification_data/request/create_date"/>
.
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>@@following_details@@: </b>
                                    <xsl:value-of select="notification_data/phys_item_display/author"/>
:
                                    <xsl:value-of select="notification_data/phys_item_display/title"/>
(Barcode:
                                    <xsl:value-of select="notification_data/phys_item_display/barcode"/>
)
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>@@delivered_to@@: </b>
                                    <xsl:value-of select="substring-after(notification_data/delivery_address,':')"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>@@due_date@@: </b>
                                    <xsl:value-of select="substring(notification_data/due_date,1,10)"/>
                                </td>
                            </tr>
                        </table>
                        <br/>
                        <table>
                            <tr>
                                <td>
@@sincerely@@
                                    <br/>
                                    <xsl:value-of select="notification_data/organization_unit/name"/>
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
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>