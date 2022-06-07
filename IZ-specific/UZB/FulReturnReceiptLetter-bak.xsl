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
        <xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->


		<div class="messageArea">
        <div class="messageBody">


        	<table cellspacing="0" cellpadding="5" border="0">
				<tr>
				<td>
					<h>@@inform_returned_items@@ </h>
				</td>
				</tr>



              	<xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
					<tr>
						<td>
							<table cellpadding="5" class="listing">
								<xsl:attribute name="style">
									<xsl:call-template name="mainTableStyleCss" />
								</xsl:attribute>
								<tr align="center" bgcolor="#f5f5f5">
									<td colspan="7">
										<h3><xsl:value-of select="organization_unit/name" /></h3>
                                                                                                                                                                                                                                <br/>
                                                                                       	<xsl:value-of select="organization_unit/address/line1"/><br/>
			                                                                <xsl:value-of select="organization_unit/address/line2"/><br/>
                                                                                        <xsl:if test="string-length(organization_unit/address/line3)!=0">
                                                                                        <xsl:value-of select="organization_unit/address/line3"/><br/>
                                                                                        </xsl:if>
                                                                                         <xsl:if test="string-length(organization_unit/address/line4)!=0">
                                                                                         <xsl:value-of select="organization_unit/address/line4"/><br/>
                                                                                         </xsl:if>
		                                                                        <xsl:value-of select="organization_unit/address/postal_code"/>&#160;<xsl:value-of select="organization_unit/address/city"/><br/>
                                                                                       <xsl:value-of select="organization_unit/phone/phone"/><br/> 
                                                                                       <xsl:value-of select="organization_unit/email/email"/><br/> 
									</td>
								</tr>
								<tr>
									<th>@@title@@</th>
									<th>@@description@@</th>
									<th>@@author@@</th>
									<th>@@due_date@@</th>
									<th>@@return_date@@</th>
									<th>@@fine@@</th>
									<th>@@library@@</th>
								</tr>

								<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display/item_loan">
									<tr>
										<td><xsl:value-of select="title"/></td>
										<td><xsl:value-of select="barcode"/></td>
										<td><xsl:value-of select="author"/></td>
										<td><xsl:value-of select="new_due_date_str"/></td>
										<td><xsl:value-of select="return_date_str"/></td>
										<td><xsl:value-of select="normalized_fine"/></td>
										<td><xsl:value-of select="library_name"/></td>
									</tr>
								</xsl:for-each>
							</table>
						</td>
					</tr>
					<hr/><br/>
				</xsl:for-each>
				<br />
				<br />
			</table>

			<table>
				<tr><td>@@sincerely@@</td></tr>
				<tr><td><xsl:value-of select="notification_data/organization_unit/name" /></td></tr>
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
