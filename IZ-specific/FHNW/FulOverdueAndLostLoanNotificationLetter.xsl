<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized; reversed senderReceiver -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
	<html>
		<head>
		<xsl:call-template name="generalStyle" />
		</head>

			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->
				<xsl:call-template name="senderReceiver-reversed" /> <!-- SenderReceiver.xsl -->

				<br />
                                
                                <td>
                                           <xsl:if test="notification_data/notification_type='OverdueNotificationType1'">
                                           <b>@@additional_info_2_type1@@</b><br/><br/>
                                            </xsl:if>
                                            <xsl:if test="notification_data/notification_type='OverdueNotificationType2'">
                                           <b>@@additional_info_2_type2@@</b><br/><br/>
                                            </xsl:if>
                                            <xsl:if test="notification_data/notification_type='OverdueNotificationType3'">
                                           <b>@@additional_info_2_type3@@</b><br/><br/>
                                            </xsl:if>
                                           <xsl:if test="notification_data/notification_type='OverdueNotificationType4'">
                                           <b>@@additional_info_2_type4@@</b><br/><br/>
                                            </xsl:if>
                                 </td>
				<td>
					<h>@@inform_you_item_below@@ @@additional_info_1@@</h>
				</td>
				<br/>
			

				<table cellpadding="5" class="listing">
					<xsl:attribute name="style">
						<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
					</xsl:attribute>

					<xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
						<tr>
							<td>
								<table cellpadding="5" class="listing">
									<xsl:attribute name="style">
										<xsl:call-template name="mainTableStyleCss" />
									</xsl:attribute>
									<tr align="left" bgcolor="#f5f5f5">
										<td colspan="8">
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
										<th>@@lost_item@@</th>
										<th>@@library@@</th>
										<th>@@loan_date@@</th>
										<th>@@due_date@@</th>
										<th>@@barcode@@</th>
										<th>@@call_number@@</th>
										<th>@@charged_with_fines_fees@@</th>
									</tr>

									<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display">
										<tr>
											<td><xsl:value-of select="item_loan/title"/></td>
											<td><xsl:value-of select="physical_item_display_for_printing/library_name"/></td>
											<td><xsl:value-of select="item_loan/loan_date"/></td>
											<td><xsl:value-of select="item_loan/due_date"/></td>
											<td><xsl:value-of select="item_loan/barcode"/></td>
											<td><xsl:value-of select="physical_item_display_for_printing/call_number"/></td>
											<td>
												<xsl:for-each select="fines_fees_list/user_fines_fees">
													<b></b><xsl:value-of select="fine_fee_ammount/normalized_sum"/>&#160;<xsl:value-of select="fine_fee_ammount/currency"/>&#160;<xsl:value-of select="ff"/>
													<br />
												</xsl:for-each>
											</td>
										</tr>
									</xsl:for-each>
								</table>
							</td>
						</tr>
						<hr/><br/>
						</xsl:for-each>
						<xsl:if test="notification_data/overdue_notification_fee_amount/sum !=''">
						<tr>
							<td>
								<b>@@overdue_notification_fee@@ </b>
								<xsl:value-of select="notification_data/overdue_notification_fee_amount/normalized_sum"/>&#160;<xsl:value-of select="notification_data/overdue_notification_fee_amount/currency"/>&#160;<xsl:value-of select="ff"/>
							</td>
						</tr>
						</xsl:if>

			
					<br />

					
					</table>
  					          
							<td>@@sincerely@@<br/>
							<xsl:value-of select="notification_data/organization_unit/name" />
                                                       
                                                       <br/><br/><i>powered by SLSP</i></td>
                                                       
					
				
				
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>