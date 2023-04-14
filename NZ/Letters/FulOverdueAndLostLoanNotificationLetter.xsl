<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 10/2021
		10/2021 - fix date in header
		11/2021 - senderReceiver-receiver-only: added 1cm margin on the left side to better fit envelope window
		11/2021 - body style: font-size: 100%
		02/2022 - added greeting to all languages
		05/2022 - synced adaptations of header and senderReceiver to local templates
		12/2022 - added SLSP greeting template
		04/2023 - Added IZ message template -->
<!-- Dependance: 
        style - generalStyle, bodyStyleCss, listStyleCss, mainTableStyleCss
        recordTitle - SLSP-multilingual, SLSP-userAccount
         -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />

<!-- Return specific recall type label based on overdue notification type -->
<xsl:template name="recall-type">
	<xsl:choose>
		<xsl:when test="/notification_data/notification_type='OverdueNotificationType1'">@@additional_info_2_type1@@</xsl:when>
		<xsl:when test="/notification_data/notification_type='OverdueNotificationType2'">@@additional_info_2_type2@@</xsl:when>
		<xsl:when test="/notification_data/notification_type='OverdueNotificationType3'">@@additional_info_2_type3@@</xsl:when>
		<xsl:when test="/notification_data/notification_type='OverdueNotificationType4'">@@additional_info_2_type4@@</xsl:when>
	</xsl:choose>
</xsl:template>

<!--
	insert logo & header
-->
<xsl:template name="head-overdue-letter">
	<table cellspacing="0" cellpadding="5" border="0">
		<!-- SLSP: overloading the height parameter to overwrite the style -->
			<xsl:attribute name="style">
			<xsl:call-template name="headerTableStyleCss" />; height: 35mm;
		</xsl:attribute>
		<!-- LOGO INSERT -->
		<tr>
		<xsl:attribute name="style">
			<xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>
			<td colspan="2">
				<div id="mailHeader">
					<div id="logoContainer" class="alignLeft">
						<!-- SLSP: fixed height of logo -->
						<img onerror="this.src='/infra/branding/logo/logo-email.png'" src="cid:logo.jpg" alt="logo" style="height:20mm"/>
					</div>
				</div>
			</td>
		</tr>
		<!-- END OF LOGO INSERT -->
		<tr>
			<xsl:for-each select="notification_data/general_data">
				<td>
					<h1><xsl:value-of select="subject"/>&#160;-&#160;<xsl:call-template name="recall-type" /></h1>
				</td>
				<td align="right">
					<xsl:value-of select="current_date"/>
				</td>
			</xsl:for-each>
		</tr>
	</table>
</xsl:template>
<!-- 
The template outputs different recall deadlines based on the name of last applied Overdue profile.
The overdue profile setting is in Configuration -> Fulfillment -> Overdue and Lost Loan Profile
If overdue profiles are changed then the text bellow has to be adapted.
-->
<xsl:template name="overdue-info-title">
	<xsl:param name="profile_names"/>
	<!-- we can extract overdue profile for each title using notification_data/loans_by_library/library_loans_for_display/item_loans/overdue_and_lost_loan_notification_display/physical_item_display_for_printing/profile_names -->
	<!-- Extract the last Overdue profile applied -->
	<xsl:variable name="profile_names_tok" select="str:tokenize($profile_names, ';')"/>
	<xsl:variable name="last_profile" select="$profile_names[count($profile_names_tok)]"/>
	<!-- output the recall deadlines -->
	<xsl:for-each select="$last_profile">
		<xsl:choose>
			<xsl:when test="contains(., '14 and 28 Days')">
				@@charged_with_fines_fees_type1@@
			</xsl:when>
			<xsl:when test="contains(., '1 Day')">
				<!-- 1 Open Day -->
				@@charged_with_fines_fees_type3@@
			</xsl:when>
			<xsl:when test="contains(., '7 Days')">
				<!-- 3 Open Days -->
				@@charged_with_fines_fees_type2@@
			</xsl:when>
			<xsl:when test="contains(., 'Same Day')">
				<!-- 1 Open Day -->
				@@charged_with_fines_fees_type3@@
			</xsl:when>
		</xsl:choose>
	</xsl:for-each>
</xsl:template>

<!-- Template to output the delivery address only, on the right side -->
<xsl:template name="senderReceiver-receiver-only">
	<table cellspacing="0" border="0" width="100%">
		<tr>
			<td width="50%"  align="left"></td>
			<td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm;">
				<table cellspacing="0" cellpadding="0" border="0">
					<xsl:attribute name="style">
						font-weight: 600;
						<xsl:call-template name="listStyleCss" />
						<!-- style.xsl -->
					</xsl:attribute>
					<tr>
						<td>
							<xsl:value-of select="/notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="/notification_data/user_for_printing/last_name"/>
						</td>
					</tr>
					<xsl:if test="string-length(/notification_data/user_for_printing/address1)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address1"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address2)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address2"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address3)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address3"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address4)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address4"/>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td>
							<xsl:value-of select="/notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="/notification_data/user_for_printing/city"/>
						</td>
					</tr>
					<!-- There is a known bug when there is no country chosen for the user. this change in the letter component called "SenderReceiver.xsl" will do the trick -->
					<tr>
						<td>
							<xsl:choose>
								<xsl:when test="/notification_data/user_for_printing/country = 'Null'">
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="/notification_data/user_for_printing/country = 'CHE'">
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/notification_data/user_for_printing/country"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</xsl:template>

<!-- Template to print only delivery address only, on right side -->
<xsl:template name="senderReceiver-receiver-only-reversed">
	<table cellspacing="0" border="0" width="100%">
		<tr>
			<td width="50%"  align="left" style="padding: 10mm 10mm 10mm 10mm;">
				<table cellspacing="0" cellpadding="0" border="0">
					<xsl:attribute name="style">
						font-weight: 600;
						<xsl:call-template name="listStyleCss" />
						<!-- style.xsl -->
					</xsl:attribute>
					<tr>
						<td>
							<xsl:value-of select="/notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="/notification_data/user_for_printing/last_name"/>
						</td>
					</tr>
					<xsl:if test="string-length(/notification_data/user_for_printing/address1)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address1"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address2)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address2"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address3)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address3"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="string-length(/notification_data/user_for_printing/address4)!=0">
						<tr>
							<td>
								<xsl:value-of select="/notification_data/user_for_printing/address4"/>
							</td>
						</tr>
					</xsl:if>
					<tr>
						<td>
							<xsl:value-of select="/notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="/notification_data/user_for_printing/city"/>
						</td>
					</tr>
					<!-- There is a known bug when there is no country chosen for the user. this change in the letter component called "SenderReceiver.xsl" will do the trick -->
					<tr>
						<td>
							<xsl:choose>
								<xsl:when test="/notification_data/user_for_printing/country = 'Null'">
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:when test="/notification_data/user_for_printing/country = 'CHE'">
									<xsl:text> </xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/notification_data/user_for_printing/country"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</table>
			</td>
			<td width="50%" align="left" ></td>
		</tr>
	</table>
</xsl:template>


<xsl:template match="/">
	<html>
		<head>
			<xsl:call-template name="generalStyle" />
		</head>
		<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" />;font-size: 100%;
			</xsl:attribute>
			<!-- Use specific header with information what recall this is -->
			<xsl:call-template name="head-overdue-letter" />
			<!-- Show patron address only for special cases - user group 92 or 3rd Recall -->
			<xsl:if test="notification_data/user_for_printing/user_group = '92' or notification_data/notification_type = 'OverdueNotificationType4'">
				<xsl:call-template name="senderReceiver-receiver-only" />
			</xsl:if>
			<br />
			<div id="user-additional-info" align="left">
				<p>
					<strong>
						<xsl:call-template name="recall-type" /><br />
					</strong>
					<!-- set the Barcode NZ, if there are more then only first one is returned -->
					<xsl:variable name="NZ_barcode">
						<xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[code='02']/value"/>
					</xsl:variable>
					<!-- set the Barcode edu-ID, if there are more then only first one is returned -->
					<xsl:variable name="edu-id_barcode">
						<xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[code='01']/value"/>
					</xsl:variable>
					<xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="notification_data/user_for_printing/last_name"/><br />
					@@borrowed_by_you@@:
					<xsl:choose>
						<xsl:when test="$edu-id_barcode != ''">
							<xsl:value-of select="$edu-id_barcode"/><br />
						</xsl:when>
						<xsl:when test="$NZ_barcode != ''">
							<xsl:value-of select="$NZ_barcode"/><br />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[code='Primary Identifier']/value"/>
						</xsl:otherwise>
					</xsl:choose>
					<br/>
				</p>
			</div>
			<p>
				<!-- Workaround for deleted label dear by Ex Libris in December 2022 -->
				<xsl:call-template name="SLSP-greeting" />
			</p>
			<p>
				<xsl:choose>
					<xsl:when test="/notification_data/notification_type = 'OverdueNotificationType1'">
						@@inform_you_item_below@@
						@@additional_info_1_type1@@
					</xsl:when>
					<xsl:when test="/notification_data/notification_type = 'OverdueNotificationType2'">
						@@inform_you_item_below@@
						@@inform_you_item_below_type1@@
						@@additional_info_1_type2@@
					</xsl:when>
					<xsl:when test="/notification_data/notification_type = 'OverdueNotificationType3'">
						@@inform_you_item_below@@
						@@inform_you_item_below_type1@@
						@@additional_info_1_type3@@
					</xsl:when>
					<xsl:when test="/notification_data/notification_type = 'OverdueNotificationType4'">
				<!-- If the user does not have a block after the 3rd recall then don't print the account blocked info -->
						<xsl:if test="notification_data/user_for_printing/blocks != ''">
							@@inform_you_item_below@@
							@@inform_you_item_below_type1@@
							@@additional_info_1_type4@@
						</xsl:if>
						<xsl:if test="notification_data/user_for_printing/blocks = ''">
							@@inform_you_item_below@@
						</xsl:if>
					</xsl:when>
				</xsl:choose>
			</p>
			<br/>
			<table cellpadding="5" width="100%">
				<xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
					<tr>
						<td>
							<table cellpadding="5" class="listing">
								<xsl:attribute name="style">
									<xsl:call-template name="mainTableStyleCss" />
								</xsl:attribute>
								<thead>
									<tr align="left" bgcolor="#f5f5f5">
										<td colspan="3">
											<h3>
												<xsl:value-of select="organization_unit/name" />
											</h3>
											<xsl:if test="organization_unit/address/line1 != ''">
												<xsl:value-of select="organization_unit/address/line1"/>,
											</xsl:if>
											<xsl:if test="organization_unit/address/line2 != ''">
												<xsl:value-of select="organization_unit/address/line2"/>,
											</xsl:if>
											<xsl:if test="organization_unit/address/line3 != ''">
												<xsl:value-of select="organization_unit/address/line3"/>,
											</xsl:if>
											<xsl:if test="organization_unit/address/line4 != ''">
												<xsl:value-of select="organization_unit/address/line4"/>,
											</xsl:if>
											<xsl:if test="organization_unit/address/postal_code != '' or organization_unit/address/city != ''">
												<xsl:value-of select="organization_unit/address/postal_code"/>&#160;<xsl:value-of select="organization_unit/address/city"/>
												<br/>
											</xsl:if>
											<xsl:if test="organization_unit/phone/phone != ''">
												<xsl:value-of select="organization_unit/phone/phone"/>
												<br/>
											</xsl:if>
											<xsl:if test="organization_unit/email/email != ''">
												<xsl:value-of select="organization_unit/email/email"/>
											</xsl:if>
										</td>
									</tr>
									<tr align="left">
										<th>
											@@lost_item@@
										</th>
										<th>
											@@loan_date@@ - @@due_date@@
										</th>
										<th>@@charged_with_fines_fees@@</th>
									</tr>
								</thead>
								<tbody>
									<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display">
										<tr>
											<td>
												<xsl:value-of select="substring(item_loan/title, 0, 70)"/>
												<xsl:if test="string-length(item_loan/title) > 70">...</xsl:if>
												<br />
												<strong>@@barcode@@: </strong>
												<xsl:value-of select="item_loan/barcode"/>
												<br />
												<strong>@@call_number@@: </strong>
												<xsl:choose>
													<xsl:when test="physical_item_display_for_printing/display_alt_call_numbers != ''">
														<xsl:value-of select="physical_item_display_for_printing/display_alt_call_numbers"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="physical_item_display_for_printing/call_number"/>
													</xsl:otherwise>
												</xsl:choose>
												<br />
												<xsl:if test="physical_item_display_for_printing/issue_level_description !='' and physical_item_display_for_printing/issue_level_description != 'Vol.' and physical_item_display_for_printing/issue_level_description != '_'">
													<strong>@@description@@: </strong>
													<xsl:value-of select="physical_item_display_for_printing/issue_level_description"/>
												</xsl:if>
											</td>
											<td>
												<xsl:value-of select="item_loan/loan_date"/>&#160;-&#160;<xsl:value-of select="item_loan/due_date"/>
												<xsl:if test="/notification_data/notification_type != 'OverdueNotificationType4'">
													<br />
													<xsl:if test="/notification_data/notification_type != 'OverdueNotificationType4'">
														@@notification_type@@:
													</xsl:if><xsl:call-template name="overdue-info-title">
														<xsl:with-param name="profile_names" select="physical_item_display_for_printing/profile_names"/>
													</xsl:call-template>
												</xsl:if>
											</td>
											<td>
												<xsl:for-each select="fines_fees_list/user_fines_fees">
													<xsl:value-of select="fine_fee_ammount/currency"/>&#160;<xsl:value-of select="fine_fee_ammount/normalized_sum"/>
												</xsl:for-each>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</td>
					</tr>
				</xsl:for-each>
			</table>
			<xsl:if test="/notification_data/notification_type != 'OverdueNotificationType4'">
				<div align="right" style="padding: 5px; font-size: 80%;">
					<span>
						@@additional_info_2@@
					</span>
					<hr/><br/>
				</div>
			</xsl:if>
			<p>
				<xsl:call-template name="SLSP-IZMessage"/>
			</p>
			<p>
				<xsl:call-template name="SLSP-userAccount"/>
			</p>
			<p>
				<xsl:choose>
					<xsl:when test="/notification_data/notification_type = 'OverdueNotificationType4'"> <!-- 3rd recall -->
						@@notification_profiles@@
					</xsl:when>
					<xsl:otherwise>
						@@additional_info_1@@
					</xsl:otherwise>
				</xsl:choose>
			</p>
			<p>@@sincerely@@</p>
			<p>
				<xsl:value-of select="notification_data/organization_unit/name" />
			</p>
			<br/>
			<p>
				<i>powered by SLSP</i>
			</p>
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>