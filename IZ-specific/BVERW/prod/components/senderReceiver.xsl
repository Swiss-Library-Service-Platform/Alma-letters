<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP-customized 03/2022 -->
<!-- IZ specifics: templates for acquisition: senderReceiverAcq, senderReceiverClaim -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="senderReceiver">
        <table cellspacing="0" cellpadding="5" border="0" width="100%">
            <tr>
                <td width="50%" align="left">
                    <xsl:for-each select="notification_data/organization_unit">
                        <table>
                            <xsl:attribute name="style">
                                <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                            </xsl:attribute>
                            <!-- <tr><td><xsl:value-of select="name"/></td></tr> -->
                            <xsl:if test="string-length(address/line1)!=0">
                                <tr><td><xsl:value-of select="address/line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line2)!=0">
                                <tr><td><xsl:value-of select="address/line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line3)!=0">
                                <tr><td><xsl:value-of select="address/line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line4)!=0">
                                <tr><td><xsl:value-of select="address/line4"/></td></tr>
                            </xsl:if>
                            <tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
                            <xsl:if test="string-length(phone/phone)!=0">
                                <tr><td><xsl:value-of select="phone/phone"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(email/email)!=0">
                                <tr><td><xsl:value-of select="email/email"/></td></tr>
                            </xsl:if>
                        </table>
                    </xsl:for-each>
                </td>
                <td width="50%"  align="right">
                    <xsl:choose>
                        <xsl:when test="notification_data/user_for_printing">
                            <table cellspacing="0" cellpadding="0" border="0">
                                <xsl:attribute name="style">
                                    <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="notification_data/general_data/letter_type = 'OrderListLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:when test="notification_data/general_data/letter_type = 'POLineCancellationLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:when test="notification_data/general_data/letter_type = 'ConversationLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:when test="notification_data/general_data/letter_type = 'POLineClaimLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:when test="notification_data/general_data/letter_type = 'POLineRenewalLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="notification_data/user_for_printing/last_name"/></td></tr>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="string-length(notification_data/user_for_printing/address1)!=0">
                                    <tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
                                </xsl:if>
                                <xsl:if test="string-length(notification_data/user_for_printing/address2)!=0">
                                    <tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
                                </xsl:if>
                                <xsl:if test="string-length(notification_data/user_for_printing/address3)!=0">
                                    <tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
                                </xsl:if>
                                <xsl:if test="string-length(notification_data/user_for_printing/address4)!=0">
                                    <tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
                                </xsl:if>
                                <tr><td><xsl:value-of select="notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="notification_data/user_for_printing/city"/></td></tr>
                                <!-- There is a known bug when there is no country chosen for the user. this change in the letter component called "SenderReceiver.xsl" will do the trick -->
                                <tr><td>
                                    <xsl:choose>
                                        <xsl:when test="notification_data/user_for_printing/country = 'Null'">
                                            <xsl:text> </xsl:text>
                                        </xsl:when>
                                        <xsl:when test="notification_data/user_for_printing/country = 'CHE'">
                                            <xsl:text> </xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="notification_data/user_for_printing/country"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td></tr>
                            </table>
                        </xsl:when>
                        <xsl:when test="notification_data/receivers/receiver/user">
                            <xsl:for-each select="notification_data/receivers/receiver/user">
                                <table>
                                    <xsl:attribute name="style">
                                        <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                                    </xsl:attribute>
                                    <xsl:choose>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'OrderListLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'POLineCancellationLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'ConversationLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'POLineClaimLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'POLineRenewalLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <tr><td><xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/></td></tr>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="string-length(user_address_list/user_address/line1)!=0">
                                        <tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
                                    </xsl:if>
                                    <xsl:if test="string-length(user_address_list/user_address/line2)!=0">
                                        <tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
                                    </xsl:if>
                                    <xsl:if test="string-length(user_address_list/user_address/line3)!=0">
                                        <tr><td><xsl:value-of select="user_address_list/user_address/line3"/></td></tr>
                                    </xsl:if>
                                    <xsl:if test="string-length(user_address_list/user_address/line4)!=0">
                                        <tr><td><xsl:value-of select="user_address_list/user_address/line4"/></td></tr>
                                    </xsl:if>
                                    <tr><td><xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/>&#160;</td></tr>
                                    <tr><td>
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
                                    </td></tr>
                                </table>
                            </xsl:for-each>

                        </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
            </tr>
        </table>
        <br/>
        <br/>
    </xsl:template>

    <xsl:template name="senderReceiver-reversed">
        <table cellspacing="0" cellpadding="5" border="0" width="100%">
            <tr>
                <td width="50%"  align="left">
                    <xsl:choose>
                        <xsl:when test="notification_data/user_for_printing">
                            <table cellspacing="0" cellpadding="0" border="0">
                                <xsl:attribute name="style">
                                    <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="notification_data/general_data/letter_type = 'OrderListLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:when test="notification_data/general_data/letter_type = 'POLineCancellationLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:when test="notification_data/general_data/letter_type = 'ConversationLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:when test="notification_data/general_data/letter_type = 'POLineClaimLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:when test="notification_data/general_data/letter_type = 'POLineRenewalLetter'">
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="notification_data/user_for_printing/last_name"/></td></tr>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="string-length(notification_data/user_for_printing/address1)!=0">
                                    <tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
                                </xsl:if>
                                <xsl:if test="string-length(notification_data/user_for_printing/address2)!=0">
                                    <tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
                                </xsl:if>
                                <xsl:if test="string-length(notification_data/user_for_printing/address3)!=0">
                                    <tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
                                </xsl:if>
                                <xsl:if test="string-length(notification_data/user_for_printing/address4)!=0">
                                    <tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
                                </xsl:if>
                                <tr><td><xsl:value-of select="notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="notification_data/user_for_printing/city"/></td></tr>
                                <!-- There is a known bug when there is no country chosen for the user. this change in the letter component called "SenderReceiver.xsl" will do the trick -->
                                <tr><td>
                                    <xsl:choose>
                                        <xsl:when test="notification_data/user_for_printing/country = 'Null'">
                                            <xsl:text> </xsl:text>
                                        </xsl:when>
                                        <xsl:when test="notification_data/user_for_printing/country = 'CHE'">
                                            <xsl:text> </xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="notification_data/user_for_printing/country"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td></tr>
                            </table>
                        </xsl:when>
                        <xsl:when test="notification_data/receivers/receiver/user">
                            <xsl:for-each select="notification_data/receivers/receiver/user">
                                <table>
                                    <xsl:attribute name="style">
                                        <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                                    </xsl:attribute>
                                    <xsl:choose>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'OrderListLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'POLineCancellationLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'ConversationLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'POLineClaimLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:when test="/notification_data/general_data/letter_type = 'POLineRenewalLetter'">
                                            <tr><td><xsl:value-of select="first_name"/></td></tr>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <tr><td><xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/></td></tr>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="string-length(user_address_list/user_address/line1)!=0">
                                        <tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
                                    </xsl:if>
                                    <xsl:if test="string-length(user_address_list/user_address/line2)!=0">
                                        <tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
                                    </xsl:if>
                                    <xsl:if test="string-length(user_address_list/user_address/line3)!=0">
                                        <tr><td><xsl:value-of select="user_address_list/user_address/line3"/></td></tr>
                                    </xsl:if>
                                    <xsl:if test="string-length(user_address_list/user_address/line4)!=0">
                                        <tr><td><xsl:value-of select="user_address_list/user_address/line4"/></td></tr>
                                    </xsl:if>
                                    <tr><td><xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/>&#160;</td></tr>
                                    <tr><td>
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
                                    </td></tr>
                                </table>
                            </xsl:for-each>

                        </xsl:when>
                        <xsl:otherwise>
                        </xsl:otherwise>
                    </xsl:choose>
                </td>
                <td width="50%" align="right">
                    <xsl:for-each select="notification_data/organization_unit">
                        <table>
                            <xsl:attribute name="style">
                                <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                            </xsl:attribute>
                            <!-- <tr><td><xsl:value-of select="name"/></td></tr> -->
                            <xsl:if test="string-length(address/line1)!=0">
                                <tr><td><xsl:value-of select="address/line1"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line2)!=0">
                                <tr><td><xsl:value-of select="address/line2"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line3)!=0">
                                <tr><td><xsl:value-of select="address/line3"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(address/line4)!=0">
                                <tr><td><xsl:value-of select="address/line4"/></td></tr>
                            </xsl:if>
                            <tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
                            <xsl:if test="string-length(phone/phone)!=0">
                                <tr><td><xsl:value-of select="phone/phone"/></td></tr>
                            </xsl:if>
                            <xsl:if test="string-length(email/email)!=0">
                                <tr><td><xsl:value-of select="email/email"/></td></tr>
                            </xsl:if>
                        </table>
                    </xsl:for-each>
                </td>
            </tr>
        </table>
        <br/>
        <br/>
    </xsl:template>

	<xsl:template name="senderReceiverAcq">
		<table cellspacing="0" cellpadding="5" border="0" width="100%">
			<tr>
			<td width="50%">
				<table>
					<xsl:attribute name="style">
						<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
					</xsl:attribute>
					<!-- <tr><td><xsl:value-of select="name"/></td></tr> -->
				<xsl:for-each select="notification_data/po/ship_to_address">
					<tr><td><xsl:value-of select="line1"/></td></tr>
					<tr><td><xsl:value-of select="line2"/></td></tr>
					<tr><td><xsl:value-of select="line3"/></td></tr>
					<tr><td><xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="city"/></td></tr>
				</xsl:for-each>
				<xsl:for-each select="notification_data">	
					<tr><td>
						<xsl:choose>	
							<xsl:when test="organization_unit/code='BIG'">
								<xsl:value-of select="po/ship_to_address/line4"/>
							</xsl:when>
							<xsl:when test="organization_unit/code='PSCH'">
								<xsl:value-of select="po/ship_to_address/line4"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="organization_unit/email/email"/>
							</xsl:otherwise>
						</xsl:choose>
					</td></tr>
					<!-- <tr><td><xsl:value-of select="address/postal_code"/></td></tr> -->
					<!-- <tr><td><xsl:value-of select="address/country"/></td></tr> -->
				</xsl:for-each>
				</table>
			</td>
			<td width="50%" align="right">
				<xsl:choose>
					<xsl:when test="notification_data/user_for_printing">
						<table cellspacing="0" cellpadding="5" border="0">
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
							</xsl:attribute>
							<tr><td><b><xsl:value-of select="notification_data/user_for_printing/name"/></b></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address5"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="notification_data/user_for_printing/city"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/state"/>&#160;<xsl:value-of select="notification_data/user_for_printing/country"/></td></tr>
						</table>
					</xsl:when>
					<xsl:when test="notification_data/receivers/receiver/user">
						<xsl:for-each select="notification_data/receivers/receiver/user">
						<table>
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
							</xsl:attribute>
							<tr><td><b><xsl:value-of select="last_name"/>&#160;<xsl:value-of select="first_name"/></b></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/state_province"/>&#160;<xsl:value-of select="user_address_list/user_address/country"/></td></tr>
						</table>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="senderReceiverClaim">
		<table cellspacing="0" cellpadding="5" border="0" width="100%">
			<tr>
			<td width="50%">
				<xsl:for-each select="notification_data/organization_unit">
				<table>
					<xsl:attribute name="style">
						<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
					</xsl:attribute>
					<xsl:choose>	
							<xsl:when test="code='BIG'">
								<tr><td>Bibliothek am Guisanplatz</td></tr>
								<tr><td>Erwerbung</td></tr>
								<tr><td>Papiermühlestrasse 21A</td></tr>
								<tr><td>3003&#160;Bern</td></tr>
								<tr><td>Erwerbungbig@gs-vbs.admin.ch</td></tr>
							</xsl:when>
                                                        <xsl:when test="code='PSCH'">
								<tr><td>Pro Senectute</td></tr>
								<tr><td>Bederstrasse 33</td></tr>
								<tr><td>8002&#160;Zürich</td></tr>
								<tr><td>erwerbung@prosenectute.ch</td></tr>
							</xsl:when>
							<xsl:otherwise>
								<!-- <tr><td><xsl:value-of select="name"/></td></tr> -->
								<tr><td><xsl:value-of select="address/line1"/></td></tr>
								<tr><td><xsl:value-of select="address/line2"/></td></tr>
								<tr><td><xsl:value-of select="address/line3"/></td></tr>
								<tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
								<tr><td><xsl:value-of select="email/email"/></td></tr>
								<!-- <tr><td><xsl:value-of select="address/postal_code"/></td></tr> -->
								<!-- <tr><td><xsl:value-of select="address/country"/></td></tr> -->
							</xsl:otherwise>
						</xsl:choose>			
				</table>
				</xsl:for-each>
			</td>
			<td width="50%" align="right">
				<xsl:choose>
					<xsl:when test="notification_data/user_for_printing">
						<table cellspacing="0" cellpadding="5" border="0">
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
							</xsl:attribute>
							<tr><td><b><xsl:value-of select="notification_data/user_for_printing/name"/></b></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/address5"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="notification_data/user_for_printing/city"/></td></tr>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/state"/>&#160;<xsl:value-of select="notification_data/user_for_printing/country"/></td></tr>
						</table>
					</xsl:when>
					<xsl:when test="notification_data/receivers/receiver/user">
						<xsl:for-each select="notification_data/receivers/receiver/user">
						<table>
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
							</xsl:attribute>
							<tr><td><b><xsl:value-of select="last_name"/>&#160;<xsl:value-of select="first_name"/></b></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/state_province"/>&#160;<xsl:value-of select="user_address_list/user_address/country"/></td></tr>
						</table>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			</tr>
		</table>
	</xsl:template>	
</xsl:stylesheet>