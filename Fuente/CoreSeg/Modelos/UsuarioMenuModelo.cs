using System;
using System.ComponentModel.DataAnnotations;

namespace CoreSeg.Modelos
{
	public class VUsuarioMenuModelo
	{
		#region Propiedades

		[Display(Name = "Id")]
		public Int32 Id { get; set; }

		[Display(Name = "idCliente")]
		public Int16 idCliente { get; set; }

		[Display(Name = "Cliente")]
		public string ClienteNombre { get; set; }

		[Display(Name = "idProveedor")]
		public Int16 idProveedor { get; set; }

		[Display(Name = "Proveedor")]
		public virtual string ProveedorNombre { get; set; }

		[Display(Name = "Nombre")]
		public String Nombre { get; set; }

		[Display(Name = "EsSistema")]
		public Boolean EsSistema { get; set; }

		[Display(Name = "Activo")]
		public Boolean Activo { get; set; }

		#endregion
	}
}
