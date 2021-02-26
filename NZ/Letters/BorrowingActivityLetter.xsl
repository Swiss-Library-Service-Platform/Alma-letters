<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">

  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

<!--
    Code from: https://developers.exlibrisgroup.com/blog/simplifying-the-loan-list-in-the-borrowing-activity-letters/
    Displaying in red the overdue due dates (rule: if due date has passed, then date displayed in red)
-->
<xsl:template name="check_DueDate">
    <xsl:param name = "concatDueDate" />
    <xsl:param name = "completeDueDate" />
    <xsl:variable name="today" select="translate(substring-before(date:date-time(),'T'),'-','')"/>
    <xsl:choose>
        <xsl:when test="number($concatDueDate) &lt; number($today)">
            <span style="color:#cc0000">
                <xsl:value-of select="$completeDueDate"/>
            </span>
        </xsl:when>
        <xsl:otherwise>
            <span>
                <xsl:value-of select="$completeDueDate"/>
            </span>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


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

            <xsl:if test="notification_data/item_loans/item_loan or notification_data/overdue_item_loans/item_loan">

	              <tr>
	              	<td>
						<b>@@reminder_message@@</b>
						<br/><br/>
	                </td>
	              </tr>

                <!-- duplicit, the overdue items are also in notification_data/loans_by_library/library_loans_for_display

                <xsl:if test="notification_data/overdue_loans_by_library/library_loans_for_display">

		              <tr>
		              	<td>
							<b>@@overdue_loans@@</b>
		                </td>
		              </tr>

					<xsl:for-each select="notification_data/overdue_loans_by_library/library_loans_for_display">
						  <tr>
							<td>
								<table cellpadding="5" class="listing">
									<xsl:attribute name="style">
										<xsl:call-template name="mainTableStyleCss" />
									</xsl:attribute>
									<tr align="center" bgcolor="#f5f5f5">
										<td colspan="5">
											<h3><xsl:value-of select="organization_unit/name" /></h3>
										</td>
									</tr>
									<tr>
										<th>@@title@@</th>
										<th>@@description@@</th>
										<th>@@author@@</th>
										<th>@@due_date@@</th>
										<th>@@fine@@</th>
										<th>@@library@@</th>
									</tr>

									<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display/item_loan">
										<tr>
											<td><xsl:value-of select="title"/></td>
											<td><xsl:value-of select="description"/></td>
											<td><xsl:value-of select="author"/></td>
											<td>
                                                <xsl:call-template name="check_DueDate">
                                                <xsl:with-param name="completeDueDate" select="due_date"/>
                                                <xsl:with-param name="concatDueDate" select="concat(substring(due_date,7),substring(due_date,4,2),substring(due_date,1,2))"/> 
                                                </xsl:call-template>
                                            </td>
											<td><xsl:value-of select="normalized_fine"/></td>
											<td><xsl:value-of select="library_name"/></td>
										</tr>
									</xsl:for-each>
								</table>
							</td>
						</tr>
						<br/>
					</xsl:for-each>
				</xsl:if> -->

				<xsl:if test="notification_data/loans_by_library/library_loans_for_display">

				  <!-- <tr>
					<td>
						<b>@@loans@@</b>
					</td>
				  </tr> -->

					<xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
						<tr>
							<td>
								<table cellpadding="5" class="listing" width="100%">
									<xsl:attribute name="style">
										<xsl:call-template name="mainTableStyleCss" />
									</xsl:attribute>
									<tr align="left" bgcolor="#f5f5f5">
										<td colspan="4" style="padding-left:20">
											<h3><xsl:value-of select="organization_unit/name" /></h3>
                                                <xsl:if test="organization_unit/address/line1 != ''">
                                                    <xsl:value-of select="organization_unit/address/line1"/><br/>
                                                </xsl:if>
                                                <xsl:if test="organization_unit/address/line2 != ''">
                                                    <xsl:value-of select="organization_unit/address/line2"/><br/>
                                                </xsl:if>                                                
                                                <xsl:if test="organization_unit/address/line3 != ''">
                                                    <xsl:value-of select="organization_unit/address/line3"/><br/> 
                                                </xsl:if>
                                                <xsl:if test="organization_unit/address/line4 != ''">
                                                    <xsl:value-of select="organization_unit/address/line4"/><br/>
                                                </xsl:if>
                                                <xsl:if test="organization_unit/address/postal_code != '' or organization_unit/address/city != ''">
                                                    <xsl:value-of select="organization_unit/address/postal_code"/>&#160;<xsl:value-of select="organization_unit/address/city"/><br/>
                                                </xsl:if>
                                                <!-- <xsl:value-of select="organization_unit/address/country"/><br/>  -->
                                                <xsl:if test="organization_unit/phone != ''">
                                                    <xsl:value-of select="organization_unit/phone/phone"/><br/> 
                                                </xsl:if>
                                                <xsl:if test="organization_unit/email != ''">
                                                    <xsl:value-of select="organization_unit/email/email"/>
                                                </xsl:if>
										</td>
									</tr>
									<tr>
										<th width="60%">@@title@@</th>
										<th width="10%">@@due_date@@</th>
										<th width="10%">@@fine@@</th>
										<th width="20%">@@call_number@@</th>
									</tr>

									<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display/item_loan">
										<tr>
											<td><xsl:value-of select="title"/> <xsl:value-of select="description"/> </td>
											<td>
                                                <xsl:call-template name="check_DueDate">
                                                <xsl:with-param name="completeDueDate" select="due_date"/>
                                                <xsl:with-param name="concatDueDate" select="concat(substring(due_date,7),substring(due_date,4,2),substring(due_date,1,2))"/> 
                                                </xsl:call-template>
                                            </td>
											<td><xsl:value-of select="normalized_fine"/></td>
											<td><xsl:value-of select="call_number"/></td>
										</tr>
									</xsl:for-each>
								</table>
							</td>
						</tr>
					</xsl:for-each>
				</xsl:if>

            </xsl:if>

			  <xsl:if test="notification_data/organization_fee_list/string">
	              <tr>
	              	<td>
                        <br/>
                        <br/>
						<b>@@debt_message@@</b>
	                </td>
	              </tr>

	              <xsl:for-each select="notification_data/organization_fee_list/string">
	              	<tr>
						<td><xsl:value-of select="."/></td>
					</tr>
	              </xsl:for-each>

				  <tr>
	              	<td>
						<b>
						@@total@@ <xsl:value-of select="notification_data/total_fee"/>
						</b>
	                </td>
	              </tr>

	              <tr>
	              	<td>
						<b>@@please_pay_message@@</b>
						<br/><br/>
	                </td>
	              </tr>

			  </xsl:if>
            </table>

			<br />

			<table>
                <tr>
                    <td>@@sincerely@@<br/>
                        <xsl:value-of select="notification_data/organization_unit/name" />
                    </td>
                </tr>
                <tr>
                    <td><br/><i>powered by SLSP</i></td>
                </tr>
            </table>

          </div>
        </div>

        <!-- footer.xsl -->
   <!-- <xsl:call-template name="lastFooter" /> -->
      <!-- <xsl:call-template name="myAccount" /> -->
		<!-- <xsl:call-template name="contactUs" /> -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
