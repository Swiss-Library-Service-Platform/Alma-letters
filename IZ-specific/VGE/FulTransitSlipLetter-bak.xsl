<?xml version="1.0" encoding="utf-8"?>
<!-- sytle.xsl - 20200930, SLSP -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />
  <xsl:template match="/">
	<xsl:variable name="bibcode" select="notification_data/receivers/receiver/printer/code"/>
    <html>
      <head>
        <xsl:call-template name="generalStyle" />
		<xsl:if test="$bibcode = 'vge_baap'">
				<style>
				body {
				margin: 0;
				}
				p {
				font-size: 13px;
				margin:0.5em;
				}
				td {
				font-size: 13px;
				text-align: right;
				}
				td:first-child {
				text-align: left;
				}
				</style>
		</xsl:if>
		<xsl:if test="$bibcode != 'vge_baap'">
				<style>
				p {
				font-size: 16;
				margin: 0;
				padding: 5;
				}
				</style>
		</xsl:if>
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
              <p><b>@@from@@: </b>
                <xsl:value-of select="notification_data/request/assigned_unit_name" /></p>
              <p><b>@@to@@: </b>
                <xsl:value-of select="notification_data/request/calculated_destination_name" /></p>
              <p><b>@@print_date@@: </b>
                <xsl:value-of select="notification_data/request/create_date" />-

                <xsl:value-of select="notification_data/request/create_time" /></p>
			<xsl:choose>
				<xsl:when test="$bibcode != 'vge_baap'">
				  <p>
					  <b>@@request_id@@: </b>
					  <img src="cid:request_id_barcode.png"
					  alt="Request Barcode" />
					</p>
				  <p>
					  <b>@@item_barcode@@: </b>
					  <img src="cid:item_id_barcode.png"
					  alt="Item Barcode" />
					</p>
				</xsl:when>
				<xsl:when test="$bibcode = 'vge_baap'">
            <table cellspacing="0" cellpadding="5" border="0" width="100%">
				  <tr>
					<td>
					  <b>exemplaire : </b>
					</td>
					<td>
					  <b>demande : </b>
					</td>
				  </tr>
				  <tr>
					<td>
					  <img src="cid:item_id_barcode.png"
					  alt="Item Barcode" heigth="60"/>
					</td>
					<td>
					  <img src="cid:request_id_barcode.png"
					  alt="Request Barcode" heigth="60"/>
					</td>
				  </tr>
            </table>
				</xsl:when>
            </xsl:choose>
              <p>
                  <b>@@call_number@@: </b>
                  <xsl:value-of select="notification_data/phys_item_display/call_number" />
                </p>
			  <xsl:if test="notification_data/request/material_type_display">
				  <p><b>@@material_type@@: </b>
					<xsl:value-of select="notification_data/request/material_type_display" /></p>
			  </xsl:if>
              <xsl:if test="notification_data/user_for_printing/note">
                <p>
                    <b>@@user_note@@:</b>
                  </p>
                <p>
                    <xsl:value-of select="notification_data/user_for_printing/note" />
                  </p>
              </xsl:if>
              <xsl:if test="notification_data/request/system_notes != ''">
                <p>
                    <b>@@system_notes@@:</b>
                  </p>
                <p>
                    <xsl:value-of select="notification_data/request/system_notes" />
                  </p>
              </xsl:if>
              <xsl:if test="notification_data/request/note !=''">
				<p>
						<b>@@request_note@@:</b>
					</p>
				<p>
						<xsl:value-of select="notification_data/request/note" />
					</p>
			  </xsl:if>
              <xsl:if test="notification_data/user_for_printing/name">
                <p>
                    <b>@@requested_for@@: </b>
                    <xsl:value-of select="notification_data/user_for_printing/name" />
                  </p>
				
                <xsl:if test="notification_data/user_for_printing/email">
                  <p><b>@@email@@: </b>
                    <xsl:value-of select="notification_data/user_for_printing/email" /></p>
                </xsl:if>
                <xsl:if test="notification_data/user_for_printing/phone">
				<xsl:if test="$bibcode != 'vge_baa'">
                  <p><b>@@tel@@: </b>
                    <xsl:value-of select="notification_data/user_for_printing/phone" /></p>
				</xsl:if>
                </xsl:if>
                <p><b>User barcode: </b>
                <xsl:for-each select="notification_data/user_for_printing/identifiers/code_value">
                <xsl:if test="code = 02">
                    <xsl:value-of select="value" /> ;
                   </xsl:if>
                <xsl:if test="code = 03">
                    <xsl:value-of select="value" /> ;
                  </xsl:if>
                <xsl:if test="code = 04">
                    <xsl:value-of select="value" /> ;
                </xsl:if>
               </xsl:for-each>
			   </p>
                <xsl:if test="notification_data/request/lastInterestDate">
                  <p><b>@@expiration_date@@: </b>
                    <xsl:value-of select="notification_data/request/lastInterestDate" /></p>
                </xsl:if>
              </xsl:if>
            <table cellspacing="0" cellpadding="5" border="0">
			  <tr>
				<td>
				<xsl:call-template name="recordTitle" />
				</td>
			  </tr>
			</table>
			  <xsl:if test="notification_data/phys_item_display/owning_library_name">
                  <p><b>@@owning_library@@: </b>
                    <xsl:value-of select="notification_data/phys_item_display/owning_library_name" /></p>
                </xsl:if>
          </div>
        </div>
        <!-- recordTitle.xsl -->
   
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>