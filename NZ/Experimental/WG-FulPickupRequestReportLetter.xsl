<?xml version="1.0" encoding="utf-8"?>
<!-- WG version 2/2023
Dependance:
    header - head
    style - generalStyle, bodyStyleCss -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:variable name="counter" select="0"/>
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
				<xsl:call-template name="bodyStyleCss" />;font-size: 100%;
			</xsl:attribute>

            <xsl:call-template name="head" /> <!-- header.xsl -->

			<div class="messageArea">
				<div class="messageBody">
                    <p>
                        <xsl:call-template name="SLSP-greeting" />
                    </p>
                    <p><xsl:value-of select="notification_data/message"/></p>
                    <p><xsl:call-template name="SLSP-sincerely" /></p>
                    <p><xsl:value-of select="notification_data/organization_unit/name"/></p>
                    <br/>
                    <p>
                        <i>powered by SLSP</i>
                    </p>
				</div>
			</div>
	<!-- <xsl:call-template name="lastFooter" />  -->
</body>
</html>


	</xsl:template>
</xsl:stylesheet>