<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes" />

  <xsl:template match="/table">
    <html>
    <head>
      <meta charset="UTF-8"/>
      <link rel="stylesheet" type="text/css" href="/hl1t.css"/>
      <script type="text/javascript" src="/hl1t.js"></script>
    </head>
    <body>
      <div class="layout">
        <div class="panel" style="position: sticky; top: 0; z-index: 9; background-color: floralwhite;">
          <img style="margin: 20px; max-width: 90%;">
            <xsl:attribute name="src">data:image/jpeg;base64,<xsl:value-of select="@cache"/></xsl:attribute>
          </img>
          <table align="center" cellpadding="2" cellspacing="2">
            <tr>
              <td>
                <label for="tool">AITOOL</label><br />
                <select name="tool" id="tool">
                  <option value="OPEN" selected="selected">ChatGPT</option>
                  <option value="NNBN">NanoBanana</option>
                  <option value="GMN3">Gemini 3.0</option>
                </select><br /><br />

                <label for="dest">DESTINATION</label><br />
                <select name="dest" id="dest">
                  <option value="BOF" selected="selected">aucune</option>
                  <option value="CSN">Cuisine</option>
                  <option value="CHA">Chambre</option>
                  <option value="SLN">Salon</option>
                  <option value="SDB">Salle de bains</option>
                </select><br /><br />

                <label for="styl">STYLE</label><br />
                <select name="styl" id="styl">
                  <option value="BOF" selected="selected">neutre</option>
                  <option value="SCA">Scandinave</option>
                  <option value="CLA">Classique</option>
                  <option value="MOD">Moderne</option>
                  <option value="MED">Méditerranéen</option>
                </select><br /><br />

                <label for="prpt">PROMPT</label><br />
                <select name="prpt" id="prpt">
                  <option value="0" selected="selected">initial</option>
                  <option value="1">lumineux</option>
                  <option value="2">rafraîchit</option>
                  <option value="3">watermark</option>
                </select><br /><br />

                <button onclick="prep()">PREP</button>
                &#160;
                <button onclick="exec()">EXEC</button>
              </td>
              <td>

                <textarea name="params" id="params" rows="20" cols="35"></textarea>
<textarea id="para" style="display:none">{
  "prompt": "@PRPT",
  "n": 1,
  "size": "1536x1024",
  "quality": "high",
  "model": "gpt-image-1",
  "output_format": "jpeg",
  "input_fidelity": "high"
}</textarea>
              </td>
              <td>
                <textarea name="prompt" id="prompt" rows="20" cols="25"></textarea>
<!--textarea id="prpt" style="display:none">
***en respectant strictement la structure de la pièce***,

transforme cette pièce en DESTINATION et

refais le design intérieur en style DESIGN
</textarea-->
              </td>
            </tr>
          </table>
          <hr />
        </div>
        <main class="content">
          <xsl:for-each select="row">
            <hr />

            <div style="max-width:800px">
              <br />
              <img>
                <xsl:attribute name="src">data:image/jpeg;base64,<xsl:value-of select="stg"/></xsl:attribute>
              </img>
              <h1>
                <span><xsl:value-of select="tool"/></span>
                &#160;
                <span>
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
                </span>
                &#160;
                <textarea class="kmnt" style="width:65%; float:right;">
                  <xsl:attribute name="id">
                    <xsl:value-of select="uid"/>
                  </xsl:attribute>
                  <xsl:value-of select="kmnt"/>
                </textarea>
              </h1>
              <b>
                <xsl:text>dest : </xsl:text><xsl:value-of select="dest"/>
                <xsl:text> ; styl : </xsl:text><xsl:value-of select="styl"/>
                <xsl:text> ; time : </xsl:text><xsl:value-of select="dly"/>
              </b><br />
              <i><xsl:value-of select="prpt"/></i><br />
              <tt><xsl:value-of select="rest"/></tt>
            </div>

          </xsl:for-each>
          <hr />
        </main>
      </div>
      <iframe id="actor" name="actor"></iframe>
    </body>
    </html>
  </xsl:template>

  <!-- Recursive star rendering -->
  <xsl:template name="stars">
    <xsl:param name="i"/>
    <xsl:param name="max"/>
    <xsl:param name="rid"/>
    <xsl:param name="uid"/>
    <xsl:param name="note"/>
    <xsl:if test="$i &lt;= $max">
      <a target="actor">
        <xsl:attribute name="id">_<xsl:value-of select="$rid"/>_<xsl:value-of select="$i"/>_</xsl:attribute>
        <xsl:attribute name="onclick">note(this.id, <xsl:value-of select="$i"/>)</xsl:attribute>
        <xsl:attribute name="href">
          <xsl:text>https://pgr.directmandat.com/hldw?auth={{auth}}&amp;uid=</xsl:text>
          <xsl:value-of select="$uid"/>
          <xsl:text>&amp;note=</xsl:text>
          <xsl:value-of select="$i"/>
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
