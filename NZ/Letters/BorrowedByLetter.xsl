<?xml version="1.0" encoding="utf-8"?>
<!-- WG: Letters 10/2022
	Dependancy:
		header - head
		style - generalStyle, bodyStyleCss, listStyleCss
		recordTitle - SLSP-multilingual
-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">

  <xsl:include href="header.xsl" />
  <xsl:include href="senderReceiver.xsl" />
  <xsl:include href="mailReason.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="style.xsl" />
  <xsl:include href="recordTitle.xsl" />

  <!-- Accepts label text from Alma via parameter label and replaces the %% with content of parameter var
	USAGE:
	<xsl:variable name="label_raw">
		<label_in_alma>
	</xsl:variable>
	<xsl:variable name="insert">
		<xsl:value-of select="notification_data/path/to/data" />
	</xsl:variable>
	<xsl:call-template name="printLabel">
		<xsl:with-param name="label" select="$label_raw"/>
		<xsl:with-param name="var" select="$insert"/>
	</xsl:call-template>
 -->
  <xsl:template name="printLabel">
	<xsl:param name="label" />
 	<xsl:param name="var" />
	<!-- If the label text does not contain %%, return error in the letter editor -->
	<xsl:if test="not(contains($label, '%%'))">
 		<xsl:message terminate="yes">
			"<xsl:value-of select="$label" />" does not contain "%%"
		</xsl:message>
	</xsl:if>
	<!-- Extract the label text before and after the %% marks -->
	<xsl:variable name="labelPart1">
		<xsl:value-of select="substring-before($label, '%%')" />
	</xsl:variable>
	<xsl:variable name="labelPart2">
		<xsl:value-of select="substring-after($label, '%%')" />
	</xsl:variable>
	<xsl:value-of select="concat($labelPart1, $var, $labelPart2)" />
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

        <div class="messageArea">
          <div class="messageBody">
			<table cellspacing="0" cellpadding="1" border="0">
				<xsl:for-each select="notification_data/receivers/receiver/user">
					<tr>
						<td>
							<br />
							<xsl:if test="user_group = '92'">
								<strong>
									<xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
										<xsl:with-param name="en" select="'Special user cantonal library'"/>
										<xsl:with-param name="fr" select="'Utilisateur spécial bibliothèque cantonale'"/>
										<xsl:with-param name="it" select="'Utente speciale biblioteca cantonale'"/>
										<xsl:with-param name="de" select="'Spezialnutzende Kantonsbibliothek'"/>
									</xsl:call-template>
								</strong><br />
							</xsl:if>
							<xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/><br />
							<!-- set the barcode values in variables -->
							<!-- set the Barcode NZ, if there are more then only first one is returned -->
							<xsl:variable name="NZ_barcode">
								<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='02']/value"/>
							</xsl:variable>
							<!-- set the Barcode edu-ID, if there are more then only first one is returned -->
							<xsl:variable name="edu-id_barcode">
								<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='01']/value"/>
							</xsl:variable>
							<!-- set the Barcode IZ, if there are more then only first one is returned -->
							<xsl:variable name="IZ_barcode">
								<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='03']/value"/>
							</xsl:variable>
							<!-- set the barcode values in variables -->

							<xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
								<xsl:with-param name="en" select="'User ID'"/>
								<xsl:with-param name="fr" select="'ID utilisateur'"/>
								<xsl:with-param name="it" select="'ID utente'"/>
								<xsl:with-param name="de" select="'Benutzer-ID'"/>
							</xsl:call-template>: 
							<xsl:choose>
								<xsl:when test="$edu-id_barcode != ''">
									<xsl:value-of select="$edu-id_barcode"/><br />
								</xsl:when>
								<xsl:when test="$NZ_barcode != ''">
									<xsl:value-of select="$NZ_barcode"/><br />
								</xsl:when>
								<xsl:when test="$IZ_barcode != ''">
									<xsl:value-of select="$IZ_barcode"/><br />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='Primary Identifier']/value"/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</xsl:for-each>
				<tr>
					<td>
						<br />
						<xsl:call-template name="SLSP-multilingual">
							<xsl:with-param name="en" select="'Hello,'"/>
							<xsl:with-param name="fr" select="'Bonjour,'"/>
							<xsl:with-param name="it" select="'Buongiorno,'"/>
							<xsl:with-param name="de" select="'Guten Tag'"/>
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:variable name="label_raw">
							@@the_item@@
						</xsl:variable>
						<xsl:variable name="proxy">
							<xsl:value-of select="notification_data/borrower/first_name" />&#160;<xsl:value-of select="notification_data/borrower/last_name" />
						</xsl:variable>
						<xsl:call-template name="printLabel">
							<xsl:with-param name="label" select="$label_raw"/>
							<xsl:with-param name="var" select="$proxy"/>
						</xsl:call-template>
					</td>
				</tr>
				<xsl:variable name="callNo">
					<xsl:choose>
						<xsl:when test="notification_data/phys_item_display/display_alt_call_numbers != ''">
							<xsl:value-of select="notification_data/phys_item_display/display_alt_call_numbers"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="notification_data/phys_item_display/call_number"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<tr>
					<td>
						<br/>
						<xsl:call-template name="recordTitle" />
						<xsl:if test="$callNo != ''">
							<strong><xsl:call-template name="SLSP-multilingual">
								<xsl:with-param name="en" select="'Call Number'"/>
								<xsl:with-param name="fr" select="'Cote'"/>
								<xsl:with-param name="it" select="'Segnatura'"/>
								<xsl:with-param name="de" select="'Signatur'"/>
							</xsl:call-template>: </strong>
							<xsl:value-of select="$callNo"/>
						</xsl:if>
					</td>
				</tr>
				<tr>
					<td>
						<br/>
						@@sincerely@@
					</td>
				</tr>
				<tr>
					<td>
						<xsl:value-of select="notification_data/organization_unit/name" />
					</td>
				</tr>
				<tr>
					<td>
						<br/><i>powered by SLSP</i>
					</td>
				</tr>
			</table>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>