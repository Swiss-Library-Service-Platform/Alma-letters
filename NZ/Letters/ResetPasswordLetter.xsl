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
					<!-- Do not send the letter if user group is not allowed to reset password
						The user group codes are not only numbers so we need to list the allowed
						user groups and catch others in "otherwise"
					-->
					<xsl:for-each select="notification_data/receivers/receiver">
						<xsl:choose>
							<xsl:when test="user/user_group = '11'"></xsl:when> <!-- letter passes-->
							<xsl:when test="user/user_group = '12'"></xsl:when> <!-- letter passes-->
							<xsl:when test="user/user_group = '13'"></xsl:when> <!-- letter passes-->
							<xsl:when test="user/user_group = '14'"></xsl:when> <!-- letter passes-->
							<xsl:when test="user/user_group = '15'"></xsl:when> <!-- letter passes-->
							<xsl:when test="user/user_group = '16'"></xsl:when> <!-- letter passes-->
							<xsl:otherwise>
								<xsl:message terminate="yes">User group is not allowed to reset password.</xsl:message>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
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