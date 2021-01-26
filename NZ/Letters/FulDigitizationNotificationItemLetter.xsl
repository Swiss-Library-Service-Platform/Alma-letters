<?xml version="1.0" encoding="utf-8"?>
<!-- sytle.xsl - 20200929, SLSP -->
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
  <xsl:variable name="isDeposit" select="/notification_data/request/deposit_indicator" />
  <xsl:variable name="isDigitalDocDelivery" select="/notification_data/digital_document_delivery" />
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
        <xsl:call-template name="senderReceiver" />
        <!-- SenderReceiver.xsl -->
        <div class="messageArea">
          <div class="messageBody">
            <table cellspacing="0" cellpadding="5" border="0">
				
					<td>@@your_request@@<br/>
                                 <xsl:value-of select="notification_data/phys_item_display/author"/>: <xsl:value-of select="notification_data/phys_item_display/title"/> (Barcode: <xsl:value-of select="notification_data/phys_item_display/barcode"/>)</td> <br/>
				
				<xsl:if test="$isDeposit='true'">
			
			
					
					<a>
                        <xsl:attribute name="href">
                          <xsl:value-of select="notification_data/item_url" />
                        </xsl:attribute>
						<xsl:value-of select="notification_data/phys_item_display/title"/>
					</a>
					
				
				</xsl:if>

				<xsl:if test="$isDigitalDocDelivery='true' or $isDeposit='false'"> <!-- DOCUMENT DELIVERY -->
			
				<xsl:if test="not(/notification_data/url_list[string])">
						@@request_type_digitization@@ 
						<br/>
                                                
					 </xsl:if>
	

					<xsl:if test="/notification_data/url_list[string]">
						
							@@attached_are_the_urls@@ <br/>
						
                                       
						<xsl:for-each select="/notification_data/attachments_list/attachments">
							<xsl:if test="url">
							
								
									<a>
									<xsl:attribute name="href">
										<xsl:value-of select="url" />
									</xsl:attribute>
									<xsl:value-of select="url" />
									</a>   
                                                 <xsl:if test="string-length(notes)!=0">
                                                (<xsl:value-of select="notes"/>)	
                                                </xsl:if>				
                                   	       <br/>
								
							

							</xsl:if>
						</xsl:for-each>

					</xsl:if>
                                       

                </xsl:if>

		
            <tr>
				<td>@@sincerely@@ <br/> <xsl:value-of select="notification_data/organization_unit/name" /></td> 
                               
					</tr>

                                                       <tr>
                                                       <td><br/><i>powered by SLSP</i></td>
                                                       </tr>
			</table>
          </div>
        </div>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

