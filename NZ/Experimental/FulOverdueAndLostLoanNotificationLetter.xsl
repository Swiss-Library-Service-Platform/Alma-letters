<?xml version="1.0" encoding="utf-8"?>
<!-- sytle.xsl - 20200929, SLSP -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<!-- 
    The template outputs different recall deadlines based on the name of last applied Overdue profile.
    The overdue profile setting is in Configuration -> Fulfillment -> Overdue and Lost Loan Profile
    If overdue profiles are changed then the text bellow has to be adapted.

    Open Questions:
    - How often the overdue profiles change?
    - Is the naming for Overdue profiles defined by SLSP?
    - 
    Variables between IZs:
    - 
	-->
	<xsl:template name="overdue-info-title">
		<xsl:param name="profile_names"/>
		<!-- we can extract overdue profile for each title using notification_data/loans_by_library/library_loans_for_display/item_loans/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/profile_names -->
        <!-- *********Testing recall deadlines based on the Overdue Profile*********<br /> -->
		<!-- Extract the last Overdue profile applied -->
		<xsl:variable name="profile_names_tok" select="str:tokenize($profile_names, ';')"/>
        <xsl:variable name="last_profile" select="$profile_names[count($profile_names_tok)]"/>
		<br />
        <!-- output the recall deadlines -->
        <xsl:for-each select="$last_profile">
            <!-- Last Profile: <xsl:value-of select="."/>
            <br /> -->
			<xsl:choose>
                <xsl:when test="contains(., '14 and 28 Days')">
                    Week
                </xsl:when>
                <xsl:when test="contains(., '1 Day')">
                    1 Day
                </xsl:when>
                <xsl:when test="contains(., '7 Days')">
                    3 Days
                </xsl:when>
                <xsl:when test="contains(., 'Same Day')">
                    1 Day
                </xsl:when>
            <!-- <xsl:choose>
                <xsl:when test="contains(., '14 and 28 Days')">
                    1st Recall: 7 Open Days after Due date<br />
                    2nd Recall: 13 Open Days after Due date<br />
                    3rd Recall: 19 Open Days after Due date<br />
                </xsl:when>
                <xsl:when test="contains(., '1 Day')">
                    1st Recall: 2 Open Days after Due date<br />
                    2nd Recall: 3 Open Days after Due date<br />
                    3rd Recall: 4 Open Days after Due date<br />
                </xsl:when>
                <xsl:when test="contains(., '7 Days')">
                    1st Recall: 4 Open Days after Due date<br />
                    2nd Recall: 7 Open Days after Due date<br />
                    3rd Recall: 10 Open Days after Due date<br />
                </xsl:when>
                <xsl:when test="contains(., 'Same Day')">
                    1st Recall: 1 Open Days after Due date<br />
                    2nd Recall: 2 Open Days after Due date<br />
                    3rd Recall: 3 Open Days after Due date<br />
                </xsl:when> -->
                <!-- <xsl:otherwise><xsl:value-of select="en"/></xsl:otherwise> -->
            </xsl:choose>
        </xsl:for-each>
      <!--   <br />
        *********Testing recall deadlines based on the Overdue Profile*********<br /><br /> -->
	</xsl:template>

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
				<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

				<br />
				<!-- test -->
				<!-- <xsl:call-template name="overdue-info">
					<xsl:with-param name="en" select="'Owning library'"/>
				</xsl:call-template> -->
                                
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
										<th>Escalation period</th>
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
											<td>
												<xsl:call-template name="overdue-info-title">
													<xsl:with-param name="profile_names" select="physical_item_display_for_printing/profile_names"/>
												</xsl:call-template>
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