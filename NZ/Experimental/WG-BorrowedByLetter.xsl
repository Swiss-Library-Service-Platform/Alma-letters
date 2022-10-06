<?xml version="1.0" encoding="utf-8"?>
<!-- sytle.xsl - 20200918, SLSP -->
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
          <xsl:call-template name="bodyStyleCss" /><!-- style.xsl -->
        </xsl:attribute>

        <xsl:call-template name="head" /><!-- header.xsl -->
        <br/>
        <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->


		&#160;
        <div class="messageArea">
          <div class="messageBody">
			<table cellspacing="0" cellpadding="1" border="0">
              <tr>
              	<td>
            		@@the_item@@ 
			 <xsl:value-of select="notification_data/borrower/first_name"/>  <xsl:value-of select="notification_data/borrower/last_name"/>: <br/>
                        <xsl:value-of select="notification_data/phys_item_display/author"/>: <b><xsl:value-of select="notification_data/phys_item_display/title"/></b>  (Barcode: <xsl:value-of select="notification_data/phys_item_display/barcode"/>)<br/>

                </td>
              </tr>
		

			<table>
				<br/>
				<tr><td>@@sincerely@@</td></tr>
				<tr><td><xsl:value-of select="notification_data/organization_unit/name" /></td></tr>
                                <tr>
                                <td><br/><i>powered by SLSP</i></td>
                                </tr>
			</table>
			</table>
          </div>
        </div>
            
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>