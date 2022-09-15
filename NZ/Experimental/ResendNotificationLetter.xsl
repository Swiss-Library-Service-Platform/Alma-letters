<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP initial adaptation, 1/2022
	Dependance:
		header - head
		style - generalStyle, bodyStyleCss
		recordTitle - SLSP-userAccount
-->
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
						<br />
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<tr>
								<td>
									<br />
									@@dear@@
								</td>
							</tr>
							<tr>
								<td>
									<h>@@find_attached@@</h>
								</td>
							</tr>
							<tr>
								<td>
									<strong>@@file_name@@ </strong>
									<xsl:value-of select="notification_data/file_name" />
								</td>
							</tr>
							<tr>
								<td>
									<xsl:call-template name="SLSP-userAccount"/>
								</td>
							</tr>
							<tr>
								<td>
									<br />
									@@sincerely@@
									<br/>
									<br/>
									<xsl:value-of select="/notification_data/organization_unit/name" />
								</td>
							</tr>
							<tr>
								<td><br/><i>powered by SLSP</i></td>
							</tr>
						</table>

						
						
					</div>
				</div>
				<!-- <xsl:call-template name="lastFooter" /> --> <!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>