using CoreGeneral.Recursos;
using NLog;

namespace CoreGeneral
{
	public static class Mensajes
	{
		private static Logger LogMensajes = LogManager.GetCurrentClassLogger();
		public static void EscribirLog(string strTipo, string strMensaje, string strOrigen)
		{
			strMensaje = string.Concat("Origen:", strOrigen, " Mensaje:", strMensaje);			
			if (strTipo == Constantes.MensajeError)
			{
				LogMensajes.Error(strMensaje);
			}
			else if (strTipo == Constantes.MensajeAlerta)
			{
				LogMensajes.Warn(strMensaje);
			}
			else if (strTipo == Constantes.MensajeInfo)
			{
				LogMensajes.Info(strMensaje);
			}
		}
	}
}