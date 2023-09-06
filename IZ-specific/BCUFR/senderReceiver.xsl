<?xml version="1.0" encoding="utf-8"?>
<!-- 
	IZ Customization: delivery on left in senderReceiver; added template senderReceiverACQ
	SLSP-customized
    	05/2022 Added padding for Post envelopes 
		05/2023 Added 5th address line; adapted bottom margin and font size of address to better fit envelope window
		09/2023 Added logic for POLineClaimAggregatedLetter to print only first name
-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- Adapted by SLSP - delivery address on left
        - Fixed padding for envelopes with window
        - Delivery address bold
        - Sender address smaller font -->
<xsl:template name="senderReceiver">
	<table cellspacing="0" cellpadding="5" border="0" width="100%">
		<tr>
			<!-- receiver -->
			<td width="50%"  align="left" style="padding: 10mm 10mm 10mm 10mm; vertical-align: top;">
				<xsl:choose>
					<xsl:when test="notification_data/user_for_printing">
						<table cellspacing="0" cellpadding="0" border="0">
							<xsl:attribute name="style">
								font-weight: 600;font-size: 10pt;
								<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
							</xsl:attribute>
							<xsl:choose>
								<xsl:when test="notification_data/general_data/letter_type = 'OrderListLetter'">
									<tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
								</xsl:when>
								<xsl:when test="notification_data/general_data/letter_type = 'POLineCancellationLetter'">
									<tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
								</xsl:when>
								<xsl:when test="notification_data/general_data/letter_type = 'ConversationLetter'">
									<tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
								</xsl:when>
								<xsl:when test="notification_data/general_data/letter_type = 'POLineClaimLetter'">
									<tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
								</xsl:when>
								<xsl:when test="notification_data/general_data/letter_type = 'POLineRenewalLetter'">
									<tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
								</xsl:when>
								<xsl:when test="notification_data/general_data/letter_type = 'POLineClaimAggregatedLetter'">
									<tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/></td></tr>
								</xsl:when>
								<xsl:otherwise>
									<tr><td><xsl:value-of select="notification_data/user_for_printing/first_name"/>&#160;<xsl:value-of select="notification_data/user_for_printing/last_name"/></td></tr>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="string-length(notification_data/user_for_printing/address1)!=0">
								<tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
							</xsl:if>
							<xsl:if test="string-length(notification_data/user_for_printing/address2)!=0">
								<tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
							</xsl:if>
							<xsl:if test="string-length(notification_data/user_for_printing/address3)!=0">
								<tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
							</xsl:if>
							<xsl:if test="string-length(notification_data/user_for_printing/address4)!=0">
								<tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
							</xsl:if>
							<xsl:if test="string-length(notification_data/user_for_printing/address5)!=0">
								<tr><td><xsl:value-of select="notification_data/user_for_printing/address5"/></td></tr>
							</xsl:if>
							<tr><td><xsl:value-of select="notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="notification_data/user_for_printing/city"/></td></tr>
							<!-- There is a known bug when there is no country chosen for the user. this change in the letter component called "SenderReceiver.xsl" will do the trick -->
							<tr><td>
								<xsl:choose>
									<xsl:when test="notification_data/user_for_printing/country = 'Null'">
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:when test="notification_data/user_for_printing/country = 'CHE'">
										<xsl:text> </xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="notification_data/user_for_printing/country"/>
									</xsl:otherwise>
								</xsl:choose>
							</td></tr>
						</table>
					</xsl:when>
					<xsl:when test="notification_data/receivers/receiver/user">
						<xsl:for-each select="notification_data/receivers/receiver/user">
							<table>
								<xsl:attribute name="style">
									font-weight: 600;font-size: 10pt;
									<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
								</xsl:attribute>
								<xsl:choose>
									<xsl:when test="/notification_data/general_data/letter_type = 'OrderListLetter'">
										<tr><td><xsl:value-of select="first_name"/></td></tr>
									</xsl:when>
									<xsl:when test="/notification_data/general_data/letter_type = 'POLineCancellationLetter'">
										<tr><td><xsl:value-of select="first_name"/></td></tr>
									</xsl:when>
									<xsl:when test="/notification_data/general_data/letter_type = 'ConversationLetter'">
										<tr><td><xsl:value-of select="first_name"/></td></tr>
									</xsl:when>
									<xsl:when test="/notification_data/general_data/letter_type = 'POLineClaimLetter'">
										<tr><td><xsl:value-of select="first_name"/></td></tr>
									</xsl:when>
									<xsl:when test="/notification_data/general_data/letter_type = 'POLineRenewalLetter'">
										<tr><td><xsl:value-of select="first_name"/></td></tr>
									</xsl:when>
									<xsl:when test="/notification_data/general_data/letter_type = 'POLineClaimAggregatedLetter'">
										<tr><td><xsl:value-of select="first_name"/></td></tr>
									</xsl:when>
									<xsl:otherwise>
										<tr><td><xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/></td></tr>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="string-length(user_address_list/user_address/line1)!=0">
									<tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
								</xsl:if>
								<xsl:if test="string-length(user_address_list/user_address/line2)!=0">
									<tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
								</xsl:if>
								<xsl:if test="string-length(user_address_list/user_address/line3)!=0">
									<tr><td><xsl:value-of select="user_address_list/user_address/line3"/></td></tr>
								</xsl:if>
								<xsl:if test="string-length(user_address_list/user_address/line4)!=0">
									<tr><td><xsl:value-of select="user_address_list/user_address/line4"/></td></tr>
								</xsl:if>
								<xsl:if test="string-length(user_address_list/user_address/line5)!=0">
									<tr><td><xsl:value-of select="user_address_list/user_address/line5"/></td></tr>
								</xsl:if>
								<tr><td><xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/>&#160;</td></tr>
								<tr><td>
									<xsl:choose>
										<xsl:when test="user_address_list/user_address/country = 'Null'">
											<xsl:text> </xsl:text>
										</xsl:when>
										<xsl:when test="user_address_list/user_address/country = 'CHE'">
											<xsl:text> </xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="user_address_list/user_address/country"/>
										</xsl:otherwise>
									</xsl:choose>
								</td></tr>
							</table>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</td>
			<!-- sender -->
			<td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm;">
				<xsl:for-each select="notification_data/organization_unit">
					<table>
						<xsl:attribute name="style">
							font-size: 9pt;
							<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
						<!-- <tr><td><xsl:value-of select="name"/></td></tr> -->
						<xsl:if test="string-length(address/line1)!=0">
							<tr><td><xsl:value-of select="address/line1"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address/line2)!=0">
							<tr><td><xsl:value-of select="address/line2"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address/line3)!=0">
							<tr><td><xsl:value-of select="address/line3"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(address/line5)!=0">
							<tr><td><xsl:value-of select="address/line5"/></td></tr>
						</xsl:if>
						<tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
						<xsl:if test="string-length(phone/phone)!=0">
							<tr><td><xsl:value-of select="phone/phone"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(email/email)!=0">
							<tr><td><xsl:value-of select="email/email"/></td></tr>
						</xsl:if>
					</table>
				</xsl:for-each>
			</td>
		</tr>
	</table>
	<br/>
	<br/>
</xsl:template>




<xsl:template name="senderReceiverACQ">
<table cellspacing="0" cellpadding="5" border="0" width="100%">
	<tr>
		<td width="50%">

<xsl:choose>
		<xsl:when test="notification_data/user_for_printing">
			<table cellspacing="0" cellpadding="5" border="0">
		<xsl:attribute name="style">
			<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>
			<tr><td><b><xsl:value-of select="notification_data/user_for_printing/name"/></b></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address5"/></td></tr>

			<tr>
<td>
<xsl:value-of select="notification_data/user_for_printing/postal_code"/>
&#160;
<xsl:value-of select="notification_data/user_for_printing/city"/>

</td>
</tr>

			<tr><td><xsl:value-of select="notification_data/user_for_printing/state"/>&#160;<xsl:value-of select="notification_data/user_for_printing/country_display"/></td></tr>

		</table>
		</xsl:when>
		<xsl:when test="notification_data/receivers/receiver/user">
			<xsl:for-each select="notification_data/receivers/receiver/user">
		<table>
		<xsl:attribute name="style">
			<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>

			<tr><td><b><xsl:value-of select="first_name"/></b></td></tr>

			<tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
			<tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
<tr><td><xsl:value-of select="user_address_list/user_address/line3"/></td></tr>
<tr><td><xsl:value-of select="user_address_list/user_address/line4"/></td></tr>
			

<tr>
<td>
<xsl:value-of select="user_address_list/user_address/postal_code"/>
&#160;
<xsl:value-of select="user_address_list/user_address/city"/>
</td>
</tr>
			<tr><td><xsl:value-of select="user_address_list/user_address/state_province"/>&#160;<xsl:value-of select="user_address_list/user_address/country_display"/></td></tr>
		</table>
	</xsl:for-each>

		</xsl:when>
		<xsl:otherwise>

		</xsl:otherwise>
	</xsl:choose>

		</td>
		<td width="50%" align="right">
			<xsl:for-each select="notification_data">
		<table>
		<xsl:attribute name="style">
			<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>


			<!--<tr><td><xsl:value-of select="organization_unit/name"/></td></tr>-->

		<xsl:choose>
			<xsl:when test="po">
				<tr><td><xsl:value-of select="po/ship_to_address/line1"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/line2"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/line3"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/line4"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/postal_code"/>&#160;<xsl:value-of select="po/ship_to_address/city"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/country_display"/></td></tr>
			</xsl:when>
			<xsl:otherwise>
<!--
				<tr><td><xsl:value-of select="organization_unit/address/line1"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/line2"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/line3"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/line4"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/postal_code"/>&#160;<xsl:value-of select="organization_unit/address/city"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/country_display"/></td></tr>
-->	
		</xsl:otherwise>

		</xsl:choose>
		
		</table>
	</xsl:for-each>
		</td>
	</tr>
</table>
</xsl:template>


</xsl:stylesheet>