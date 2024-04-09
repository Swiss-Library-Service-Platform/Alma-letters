<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized
	10/2022 Added SLSP greeting template; removed bold tags from paragraphs
	05/2023 Added IZ message; formatting changes
	04/2024 call number and description bellow title; link to user account
Dependance:
	header - head
	senderReceiver - senderReceiver
	style - generalStyle, bodyStyleCss, mainTableStyleCss
	recordTitle - SLSP-greeting, SLSP-IZMessage -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date"
xmlns:str="http://exslt.org/strings">

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

<!-- Prints the IZ message stored in label 'department' for the language of the letter.
		If value in the label is empty or with value "blank" does not print anything.
		The label can contain also HTML markup such as links or formatting.
		Warning: the label 'department' has to be available in the letter for this template to work	
		Usage:
			1. Configure the label department with text in all languages.
			2. Insert the template: <xsl:call-template name="IZMessage"/> -->
<xsl:template name="SLSP-IZMessage">
	<xsl:variable name="notice">@@department@@</xsl:variable>
	<xsl:if test="$notice != '' and $notice != 'blank'">
		<strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
			<xsl:with-param name="en" select="'Notice of the library'"/>
			<xsl:with-param name="fr" select="'Avis de la bibliothèque'"/>
			<xsl:with-param name="it" select="'Comunicazione della biblioteca'"/>
			<xsl:with-param name="de" select="'Notiz der Bibliothek'"/>
		</xsl:call-template>:</strong>&#160;<xsl:value-of select="$notice" disable-output-escaping="yes" />
	</xsl:if>
</xsl:template>

<xsl:template name="formatDecimalNumber">
  <!--
    Template to change decimal comma to decimal point
	Original code from: https://github.com/uio-library/alma-letters-ubo/blob/master/xsl/letters/call_template/header.xsl
	Can be adapted to support different language number format.

	Deletes currency string, thousand separator dot and spaces.
	Transforms ALMA decimal comma to decimal point
	Formats output with spaces for thousands and decimal point
	Adds CHF string
  -->
	<xsl:param name="value"/>
	
	<xsl:variable name="numeric_value">
		<xsl:choose>
			<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'en'">
				<xsl:value-of select="number(translate($value, ', CHF', ''))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="number(translate($value, ',. CHF', '.'))"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:decimal-format name="chf" decimal-separator="." grouping-separator="&#160;"/>
	<xsl:value-of select="format-number($numeric_value, '###&#160;###.00', 'chf')"/>&#160;CHF 
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
						<xsl:call-template name="SLSP-greeting" />
					</td>
				</tr>
				<tr>
					<td>
						@@reminder_message@@
						<br/><br/>
					</td>
				</tr>
				<xsl:if test="notification_data/loans_by_library/library_loans_for_display">
					<xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
						<tr>
							<td>
								<table cellpadding="5" class="listing" width="100%">
									<xsl:attribute name="style">
										<xsl:call-template name="mainTableStyleCss" />
									</xsl:attribute>
									<tr align="left" bgcolor="#f5f5f5">
										<td colspan="3" style="padding-left:20">
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
                                                <xsl:if test="organization_unit/phone != ''">
                                                    <xsl:value-of select="organization_unit/phone/phone"/><br/> 
                                                </xsl:if>
                                                <xsl:if test="organization_unit/email != ''">
                                                    <xsl:value-of select="organization_unit/email/email"/>
                                                </xsl:if>
										</td>
									</tr>
									<tr>
										<th width="70%">@@title@@</th>
										<th width="15%">@@due_date@@</th>
										<th width="15%">@@fine@@</th>
									</tr>
									<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display/item_loan">
										<tr>
											<td>
												<xsl:value-of select="substring(title, 0, 100)"/>
												<xsl:if test="string-length(title) > 100">...</xsl:if>
												<xsl:if test="author != ''">
													<br />
													<xsl:value-of select="author"/>
												</xsl:if>
												<xsl:choose>
													<xsl:when test="alternative_call_number != ''">
														<br/><strong>@@call_number@@: </strong><xsl:value-of select="alternative_call_number"/>
													</xsl:when>
													<xsl:when test="call_number != ''">
														<br/><strong>@@call_number@@: </strong><xsl:value-of select="call_number"/>
													</xsl:when>
												</xsl:choose><br />
												<xsl:if test="description != ''"><strong>@@description@@: </strong><xsl:value-of select="description"/></xsl:if>
											</td>
											<td>
                                                <xsl:call-template name="check_DueDate">
                                                <xsl:with-param name="completeDueDate" select="due_date"/>
                                                <xsl:with-param name="concatDueDate" select="concat(substring(due_date,7),substring(due_date,4,2),substring(due_date,1,2))"/> 
                                                </xsl:call-template>
                                            </td>
											<td><xsl:value-of select="normalized_fine"/></td>
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
						@@debt_message@@
					</td>
				</tr>
				<tr>
					<td>
						<table>
							<xsl:for-each select="notification_data/organization_fee_list/string">
								<tr>
									<td>
										<xsl:value-of select="substring-before(., ':')"/>: <!-- library -->
									</td>
									<td align="right">
										<xsl:call-template name="formatDecimalNumber"> <!-- debt -->
											<xsl:with-param name="value" select="substring-after(., ':')"/>
										</xsl:call-template>
									</td>
								</tr>
							</xsl:for-each>
								<tr>
									<td>
										<b>@@total@@</b>
									</td>
									<td align="right">
										<xsl:call-template name="formatDecimalNumber">
											<xsl:with-param name="value" select="notification_data/total_fee"/>
										</xsl:call-template>
									</td>
								</tr>
						</table>
					</td>
				</tr>
			</xsl:if>
				<tr>
					<td>
						<xsl:call-template name="SLSP-IZMessage"/>
					</td>
				</tr>
				<tr>
					<td><xsl:call-template name="SLSP-userAccount"/></td>
				</tr>
				<tr>
					<td>
						<br />
						@@sincerely@@
					</td>
				</tr>
				<tr>
					<td>
						<xsl:value-of select="notification_data/organization_unit/name" />
					</td>
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
