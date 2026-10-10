' Convierte un .docx a PDF con Microsoft Word (para revisar el Word generado).
' Uso: cscript //nologo word-a-pdf.vbs entrada.docx salida.pdf
' (PowerShell está bloqueado por directiva de grupo en este equipo.)
Set w = CreateObject("Word.Application")
w.Visible = False
Set d = w.Documents.Open(WScript.Arguments(0), False, True)
d.Fields.Update
d.SaveAs2 WScript.Arguments(1), 17
d.Close False
w.Quit
