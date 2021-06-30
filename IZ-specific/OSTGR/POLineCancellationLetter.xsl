<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized 06/2021 -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

  <xsl:variable name="conta1">0</xsl:variable>
  <xsl:variable name="stepType" select="/notification_data/request/work_flow_entity/step_type" />
  <xsl:variable name="externalRequestId" select="/notification_data/external_request_id" />
  <xsl:variable name="externalSystem" select="/notification_data/external_system" />

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
      </head>
      <body>
        <xsl:attribute name="style">
          <!-- <xsl:call-template name="bodyStyleCss" /> -->
          font-family: arial; color:#333; margin:0; padding:0em;
          <!-- style.xsl -->
        </xsl:attribute>
        <xsl:call-template name="head" />
        <!-- header.xsl -->
        <xsl:call-template name="senderReceiver" />
        <!-- SenderReceiver.xsl -->

		<!-- <h4>@@vendor_name@@: <xsl:value-of select="/notification_data/vendor/name"/></h4> -->
        <div class="messageArea">
            <div class="messageBody" style="font-size:100%">
                <p>@@introduction@@:</p>
                <strong>@@title@@: </strong>
                <!-- <xsl:value-of select="notification_data/line/title" /> -->
                <xsl:for-each select="notification_data/line/meta_data_values">
                    <xsl:value-of select="title" /><br />
                    <xsl:value-of select="publisher" />
                    <xsl:if test="acqterms_place != ''">,&#160;<xsl:value-of select="acqterms_place" />
                    </xsl:if><xsl:if test="date != ''">,&#160;<xsl:value-of select="date" /></xsl:if>
                    <br />
                    <xsl:if test="acqterms_identifierType != '' and identifier != ''">
                        <xsl:value-of select="acqterms_identifierType" />:&#160;<xsl:value-of select="identifier" />
                    </xsl:if>
                </xsl:for-each>
                <br /><br />
                <b>@@order_number@@: </b><xsl:value-of select="notification_data/line/reference_number" />
                <br />
                <b>@@order_date@@: </b><xsl:value-of select="notification_data/line/send_date" />
                <br />
                <b>@@cancellation_reason@@: </b><xsl:value-of select="notification_data/line/cancellation_reason" />
                <br />
                <b>@@cancellation_note@@: </b><xsl:value-of select="notification_data/line/cancellation_note" />
                <br />
                <br />
            </div>
        </div>
		<br />
        <table>
                <tr><td>@@sincerely@@</td></tr>
                <tr><td><xsl:value-of select="/notification_data/organization_unit/name"/></td></tr>
                <tr>
                    <td>
                        <br/><i>powered by SLSP</i>
                    </td>
                </tr>
        </table>
		<!-- <xsl:call-template name="lastFooter" />  --><!-- footer.xsl -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>