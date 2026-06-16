<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized
 06/2026: adapted to the SLSP format

 Dependance:
 header - head
 style - generalStyle, bodyStyleCss
 recordTitle - SLSP-greeting
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
			<xsl:call-template name="head" /> <!-- header.xsl -->
			
			<br/>
			
			<div class="messageArea">
				<div class="messageBody">
                    <p><xsl:call-template name="SLSP-greeting" /></p>
                    <p>@@bodyTextBeforeLink@@</p>
                    <p>@@bodyTextAfterLink@@</p>
                    <p>
                        <a style="font-size: 120%; font-weight: bold;">
		                        <xsl:attribute name="href">
		                          <xsl:value-of select="notification_data/login_url" />
		                        </xsl:attribute>
                                <xsl:attribute name="target">_blank</xsl:attribute>
                                <xsl:attribute name="alt">Login to Alma</xsl:attribute>
								@@linkLabel@@</a>
                    </p>
                    <p>@@linkNoticeText@@</p>
                    <p>@@signature@@</p>
                    <p><xsl:value-of select="notification_data/organization_unit/name" /></p>
		          </div>
				</div>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>
