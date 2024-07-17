<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP version 07/2024 -->
<!-- Dependancy: 
	recordTitle - SLSP-multilingual, SLSP-greeting
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
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->

                <div class="messageArea">
					<div class="messageBody">
                        <table role='presentation'  cellspacing="0" cellpadding="5" border="0">
				            <tr>
								<td>
									<xsl:call-template name="SLSP-greeting" />
								</td>
							</tr>
				
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/message_body" disable-output-escaping="yes"/>
                                </td>
                            </tr>
						    <tr><td>@@sincerely@@</td></tr>
						    <tr><td><xsl:value-of select="notification_data/organization_unit/name" /></td></tr>
				        </table>
				<!-- <xsl:call-template name="lastFooter" /> --> <!-- footer.xsl -->
                    </div>
                </div>
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>