<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP version 12/2022
        12/2022 Added notification type SLSP_COMMUNICATION
    Dependance: 
        header - head
        style - generalStyle, bodyStyleCss, listStyleCss, mainTableStyleCss
        recordTitle - SLSP-multilingual, SLSP-userAccount -->
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
					<xsl:call-template name="bodyStyleCss" />
					<!-- style.xsl -->
				</xsl:attribute>
				<xsl:call-template name="head" />
				<!-- header.xsl -->
                <div class="messageArea">
					<div class="messageBody">
                        <table role='presentation' cellspacing="0" cellpadding="5" border="0">
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
                                    @@Dear@@
                                </td>
                            </tr>
							<xsl:choose>
								<xsl:when test="notification_data/notification_type = 'NOTIFY_PASSWORD_CHANGE' ">
									<tr>
										<td>
											<h3>@@Line_1@@</h3>
											<xsl:value-of select="notification_data/temp_password" />
										</td>
									</tr>
									<tr>
										<td>
											<h3>@@Line_2@@</h3>
										</td>
									</tr>
								</xsl:when>
                                <!-- SLSP communication to Patrons. Reserved lines 15-20 -->
                                <xsl:when test="notification_data/notification_type = 'SLSP_COMMUNICATION'">
                                <tr>
                                    <td>
                                        @@Line_15@@
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        @@Line_16@@
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <xsl:call-template name="SLSP-userAccount"/>
                                    </td>
                                </tr>
                                </xsl:when>
							</xsl:choose>
							<tr>
								<td>
                                    @@Sincerely@@
                                </td>
							</tr>
							<tr>
								<td>
									<xsl:value-of select="notification_data/organization_unit/name" />
								</td>
							</tr>
							<!-- <xsl:if test="notification_data/organization_unit/address/line1 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line1" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line2 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line2" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line3 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line3" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line4 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line4" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/line5 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/line5" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/city !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/city" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/organization_unit/address/country !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/organization_unit/address/country" />
									</td>
								</tr>
							</xsl:if> -->
                            <tr>
                                <td>
                                    <br />
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