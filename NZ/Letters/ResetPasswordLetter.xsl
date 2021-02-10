<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
			<!-- <xsl:call-template name="senderReceiver" /> SenderReceiver.xsl -->
			<br/>
			<div class="messageArea">
				<div class="messageBody">
				<!-- terminate the letter if user group is different from Swiss Library-->
					<table cellspacing="0" cellpadding="5" border="0">
						<tr>
							<td>
								<xsl:for-each select="notification_data/receivers/receiver">
									<xsl:if test="user/user_group != '12'">
										<xsl:message terminate="yes">user group is not Swiss Library </xsl:message>
									</xsl:if>
								</xsl:for-each>
							</td>
						</tr>
					</table>
					<table cellspacing="0" cellpadding="5" border="0">
						<tr>
							<td>
						@@bodyTextBeforeLink@@
								<a>
									<xsl:attribute name="href">
										<xsl:value-of select="notification_data/reset_pw_url" />
									</xsl:attribute>
							@@linkLabel@@
								</a>
						@@bodyTextAfterLink@@
								<br/>
							</td>
						</tr>
					</table>
					<table>
						<tr>
							<td>@@signature@@
								<br/>
								<xsl:value-of select="notification_data/organization_unit/name" />
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