<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  exclude-result-prefixes="xsi">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Main template matches the root: <table> -->
  <xsl:template match="/table">
    <html>
    <head>
      <meta charset="UTF-8"/>
      <link rel="stylesheet" type="text/css" href="/hldt.css"/>
      <script type="text/javascript" src="/hldt.js"></script>
    </head>
    <body>

    <iframe id="actor" name="actor"></iframe>

    <table>
      <thead style="position:sticky; top:0; z-index:9;">
        <tr>
          <td colspan="3" style="background:floralwhite; font-size:xx-large;">
            <p style="position:fixed; left:0;">ALL</p>
            <br/><br/><hr/>
          </td>
        </tr>
      </thead>

      <!-- Pagination links -->
      <caption style="font-size:xx-large">
        <xsl:variable name="pages" select="@pages_count"/>
        <xsl:call-template name="pagination">
          <xsl:with-param name="i" select="1"/>
          <xsl:with-param name="max" select="$pages"/>
        </xsl:call-template>
      </caption>

      <!-- Iterate over <row> -->
      <xsl:for-each select="row">
        <tr>
          <xsl:attribute name="id"><xsl:value-of select="uid"/></xsl:attribute>
          <th>
            <p>
              <xsl:variable name="rid" select="id"/>
              <xsl:variable name="uid" select="uid"/>
              <xsl:variable name="note" select="number(note)"/>
              <xsl:call-template name="stars">
                <xsl:with-param name="i" select="1"/>
                <xsl:with-param name="max" select="5"/>
                <xsl:with-param name="rid" select="$rid"/>
                <xsl:with-param name="uid" select="$uid"/>
                <xsl:with-param name="note" select="$note"/>
              </xsl:call-template>
            </p>
          </th>

          <td>
            <a target="_blank">
              <xsl:attribute name="href">
                <xsl:text>/hld1?auth={{auth}}</xsl:text>
                <xsl:text>&amp;uid=</xsl:text>
                <xsl:value-of select="uid"/>
              </xsl:attribute>
              <img>
                <xsl:attribute name="src">data:image/jpeg;base64,<xsl:value-of select="cch"/></xsl:attribute>
              </img>
            </a>
          </td>
          <td>
            <img>
              <xsl:attribute name="src">data:image/jpeg;base64,<xsl:value-of select="stg"/></xsl:attribute>
            </img>
          </td>

        </tr>
        <tr><th colspan="3"><hr/></th></tr>
      </xsl:for-each>
    </table>

    </body>
    </html>
  </xsl:template>

  <!-- Pagination (recursive) -->
  <xsl:template name="pagination">
    <xsl:param name="i"/>
    <xsl:param name="max"/>
    <xsl:if test="$i &lt;= $max">
      <a>
        <xsl:attribute name="href">
          <xsl:text>hldr?auth={{auth}}</xsl:text>
          <xsl:text>&amp;pag=</xsl:text>
          <xsl:value-of select="$i"/>
        </xsl:attribute>
        <xsl:value-of select="$i"/>
      </a>
      <xsl:text> | </xsl:text>
      <xsl:call-template name="pagination">
        <xsl:with-param name="i" select="$i+1"/>
        <xsl:with-param name="max" select="$max"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Stars (recursive) -->
  <xsl:template name="stars">
    <xsl:param name="i"/>
    <xsl:param name="max"/>
    <xsl:param name="rid"/>
    <xsl:param name="uid"/>
    <xsl:param name="note"/>
    <xsl:if test="$i &lt;= $max">
      <a target="actor">
        <xsl:attribute name="id">
          <xsl:text>_</xsl:text><xsl:value-of select="$rid"/>
          <xsl:text>_</xsl:text><xsl:value-of select="$i"/>
          <xsl:text>_</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="onclick">note(this.id,<xsl:value-of select="$i"/>)</xsl:attribute>
        <xsl:attribute name="href">
          <xsl:text>https://pgr.directmandat.com/hldw?auth={{auth}}</xsl:text>
          <xsl:text>&amp;uid=</xsl:text><xsl:value-of select="$uid"/>
          <xsl:text>&amp;note=</xsl:text><xsl:value-of select="$i"/>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="$i &lt;= $note">&#9733;</xsl:when>
          <xsl:otherwise>&#9734;</xsl:otherwise>
        </xsl:choose>
      </a>
      <xsl:call-template name="stars">
        <xsl:with-param name="i" select="$i+1"/>
        <xsl:with-param name="max" select="$max"/>
        <xsl:with-param name="rid" select="$rid"/>
        <xsl:with-param name="uid" select="$uid"/>
        <xsl:with-param name="note" select="$note"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
