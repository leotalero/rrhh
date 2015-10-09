package co.sistemcobro.rrhh.web;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.ejb.EJB;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.axis.encoding.Base64;
import org.apache.log4j.Logger;
import org.xhtmlrenderer.css.parser.property.PrimitivePropertyBuilders.Height;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import co.sistemcobro.all.constante.EstadoEnum;
import co.sistemcobro.all.exception.LogicaException;
import co.sistemcobro.all.util.Archivo;
import co.sistemcobro.all.util.Csv;
import co.sistemcobro.all.util.Util;
import co.sistemcobro.hermes.bean.DirectivaContrasena;
import co.sistemcobro.rrhh.bean.IdentificacionTipo;
import co.sistemcobro.hermes.bean.UsuarioAplicacionBean;
import co.sistemcobro.hermes.bean.UsuarioBean;
import co.sistemcobro.hermes.bean.UsuarioCuenta;
//import co.sistemcobro.hermes.constante.Constante;
import co.sistemcobro.hermes.constante.UsuarioTipoBusquedaEnum;
import co.sistemcobro.rrhh.bean.Contrato;
import co.sistemcobro.rrhh.bean.EmpleadoBean;
import co.sistemcobro.rrhh.bean.EmpleadoDocumentoGenerado;
import co.sistemcobro.rrhh.bean.EmpleadoIdentificacion;
import co.sistemcobro.rrhh.bean.EmpleadoPropiedad;
import co.sistemcobro.rrhh.bean.EmpleadoSalario;
import co.sistemcobro.rrhh.bean.Empresa;
import co.sistemcobro.rrhh.bean.Fotojson;
import co.sistemcobro.rrhh.bean.Genero;
import co.sistemcobro.rrhh.bean.Prioridad;
import co.sistemcobro.rrhh.bean.Propiedad;
import co.sistemcobro.rrhh.constante.ActualEnum;
import co.sistemcobro.rrhh.constante.Constante;
import co.sistemcobro.rrhh.constante.EmpleadoTipoBusquedaEnum;
import co.sistemcobro.rrhh.ejb.ContratoEJB;
import co.sistemcobro.rrhh.ejb.EmpleadoEJB;

import co.sistemcobro.rrhh.util.FtpUtilRecursos;

/**
 * 
 * @author Leonardo talero
 * 
 */
@WebServlet(name = "EmpleadofotoServlet", urlPatterns = { "/page/empleadofoto" })
@MultipartConfig
public class EmpleadofotoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(EmpleadofotoServlet.class);

	// ResourceBundle config =
	// ResourceBundle.getBundle(Constante.FILE_CONFIG_HERMES);

	@EJB
	private EmpleadoEJB empleadoEJB;

	@EJB
	private ContratoEJB contratoEJB;

	public EmpleadofotoServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		action = action == null ? "" : action;
		try {
			if (action.equals("empleado_busqueda")) {
			//	empleado_principal(request, response);
			} 
			else if (action.equals("uploadimagen")) {
				uploadimagen(request, response);
			}
			
			else if (action.equals("cropimagen")) {
				cropimagen(request, response);
			}
			else if (action.equals("empleado_editar_foto")) {
				empleado_editar_foto(request, response);
			}
			
			

		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}
	}

	public void empleado_principal(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			request.getRequestDispatcher("../pages/empleado/empleado_busqueda.jsp").forward(request,response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}

	public void uploadimagen(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idempleado= Archivo.getParameter(request.getPart("idempleado"));
			String dummyData =Archivo.getParameter(request.getPart("dummyData"));
			Part img = request.getPart("img");
			//S imgUrl = request.getPart("imgUrl");
			String imgInitW = Archivo.getParameter(request.getPart("imgInitW"));
			//Part img = request.getPart("img");
			
			
			InputStream is = img.getInputStream();
			int k = is.available();
			byte[] b = new byte[k];
			is.read(b);
			String file = Archivo.getFullName(img);
			if(!file.equals("")|| !file.equals(null)){
				
				InputStream ispdf = img.getInputStream();
				ispdf.read(b);
				
				String fileimagen = Constante.ROOT_FILE_TEMPORARY + File.separator +file;
				File archivo = new File(fileimagen);
				FileOutputStream ospdf = new FileOutputStream(archivo);
				ospdf.write(b);

				ispdf.close();
				ospdf.close();
				
				BufferedImage bimg = ImageIO.read(new File(fileimagen));
				int width          = bimg.getWidth();
				int height         = bimg.getHeight();
				
				
				request.setAttribute("picture", archivo.getAbsolutePath().toString());
				
				
				/*Fotojson fotojson=new Fotojson();
				fotojson.setUrl(archivo.getAbsolutePath().toString());
				fotojson.setStatus("success");
				fotojson.setWidth(String.valueOf(width));
				fotojson.setHeight(String.valueOf(height));*/
				JsonObject obj1 = new JsonObject();
				obj1.addProperty("status","succes");
				  obj1.addProperty("url",archivo.getAbsolutePath().toString());
				  obj1.addProperty("width",width);
				  obj1.addProperty("height",height);
				
				 

					request.getSession().setAttribute("datajson", obj1);

					PrintWriter out = response.getWriter();

					out.println(obj1.toString());

					out.close();
				
			}
			
			//request.getRequestDispatcher("../pages/empleado/empleado_busqueda.jsp").forward(request,response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	
	public void cropimagen(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idempleado= Archivo.getParameter(request.getPart("idempleado"));
			String dummyData =Archivo.getParameter(request.getPart("dummyData"));
			//Part img = request.getPart("img");
			String imgUrl = Archivo.getParameter(request.getPart("imgUrl"));
			//String imgInitW = Archivo.getParameter(request.getPart("imgInitW"));
			  	// your image original width (the one we recieved after upload)
			String imgInitW = Archivo.getParameter(request.getPart("imgInitW"));
			Double dimgInitW= Double.parseDouble(imgInitW);
			String imgInitH = Archivo.getParameter(request.getPart("imgInitH"));
			Double dimgInitH= Double.parseDouble(imgInitH);
			//imgInitH 	// your image original height (the one we recieved after upload)
			Part img = request.getPart("imgUrl");
			 		// your new scaled image width
			String imgW = Archivo.getParameter(request.getPart("imgW"));
			Double dimgW = Double.parseDouble(imgW);
			String imgH = Archivo.getParameter(request.getPart("imgH"));
			Double dimgH= Double.parseDouble(imgH);
			
			
			String imgX1 = Archivo.getParameter(request.getPart("imgX1"));
			Double dimgX1= Double.parseDouble(imgX1);
			String imgY1 = Archivo.getParameter(request.getPart("imgY1"));
			Double dimgY1= Double.parseDouble(imgY1);
				
			String cropW = Archivo.getParameter(request.getPart("cropW"));
			Double dcropW= Double.parseDouble(cropW);
			String cropH = Archivo.getParameter(request.getPart("cropH"));
			Double dcropH= Double.parseDouble(cropH);
			
			String rotation = Archivo.getParameter(request.getPart("rotation"));
			Double drotation= Double.parseDouble(rotation);
			//String actualrotation = Archivo.getParameter(request.getPart("rotation"));
			
			
		
			String imageDataBytes = imgUrl.substring(imgUrl.indexOf(",")+1);
			//byte[] bytes=Base64.decode(imageDataBytes);
			
			
			//byte[] bytes = Base64.decode(imgUrl);
			//BufferedImage imag=ImageIO.read(new ByteArrayInputStream(bytes));
			//ImageIO.write(imag, "jpg", new File(dirName,"snap.jpg"));
			 BASE64Decoder decoder = new BASE64Decoder();
	            byte[] imageByte = decoder.decodeBuffer(imageDataBytes);
	            ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
	            BufferedImage image = ImageIO.read(bis);
	           bis.close();
			
	           
	          
	           

	       	String fileimagen = Constante.ROOT_FILE_TEMPORARY + File.separator +"imagenprueba_"+idempleado+".jpg";
	    	String fileimagenmodificada = Constante.ROOT_FILE_TEMPORARY + File.separator +"imagenpruebamod_"+idempleado+".jpg";
	
				File archivo = new File(fileimagen);
				FileOutputStream ospdf = new FileOutputStream(archivo);
				ospdf.write(imageByte);
				ospdf.close();
			   
				///-----------------------------resize
				 javaxt.io.Image imagenxt = new javaxt.io.Image(fileimagen);
				 imagenxt.setWidth(dimgInitW.intValue()); //set width, adjusts height to maintain aspect ratio
				 imagenxt.setHeight(dimgInitH.intValue()); //set height, adjusts width to maintain aspect ratio
				 imagenxt.resize(dimgW.intValue(), dimgH.intValue()); //set width and height to whatever you want
				 
				 imagenxt.crop(dimgX1.intValue(),dimgY1.intValue(),dcropW.intValue(),dcropH.intValue());
		           
				 imagenxt.rotate(drotation.intValue());
				// imagenxt.rotateCounterClockwise();
				// imagenxt.rotateClockwise();
				//-----------------------------escribe nueva imagen
				File archivomodificado = new File(fileimagenmodificada);
				FileOutputStream ospdfmod = new FileOutputStream(archivomodificado);
				byte[] b = imagenxt.getByteArray();
				ospdfmod.write(b);
				ospdfmod.close();
				
				
				 String theURL = new File(fileimagenmodificada).toURI().toURL().toString();
				
				 FileInputStream fis = new FileInputStream(fileimagenmodificada);
				 
				 ByteArrayOutputStream bos = new ByteArrayOutputStream();
			        byte[] buf = new byte[1024];
			        try {
			            for (int readNum; (readNum = fis.read(buf)) != -1;) {
			                //Writes to this byte array output stream
			                bos.write(buf, 0, readNum); 
			                System.out.println("read " + readNum + " bytes,");
			            }
			        } catch (IOException ex) {
			           // Logger.getLogger(ConvertImage.class.getName()).log(Level.SEVERE, null, ex);
			        }
			 
			        byte[] bytes = bos.toByteArray();
				 
				 
				
			        
			        
			        
				 BASE64Encoder encoder = new BASE64Encoder();
				 
		          String urlencode = encoder.encode(bytes);
		          urlencode="data:image/jpeg;base64,"+urlencode;
					
				int width          = image.getWidth();
				int height         = image.getHeight();
				
			
				
				
				
				 
				 HashMap<String, Object> mapeo=new HashMap<String, Object>();
				 
				 mapeo.put("status", "success");
				 mapeo.put("url", urlencode);
				// /rrhh/imagen/camera.png
				 
				 Gson gson = new Gson();
				 JsonObject myObj = new JsonObject();

				//	JsonElement countryObj = gson.toJsonTree(obj1);
				//	myObj.remove("data");
				//	myObj.add("data", countryObj);

					//request.getSession().setAttribute("datajson", myObj);
				
					response.setContentType("application/json");
					
					PrintWriter out = response.getWriter();
					String objecto=new Gson().toJson(mapeo);
					out.println(objecto);

					out.close();

			
			//request.getRequestDispatcher("../pages/empleado/empleado_busqueda.jsp").forward(request,response);
		} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	
	public void empleado_editar_foto(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		UsuarioBean user = (UsuarioBean) session.getAttribute(Constante.USUARIO_SESSION);
		try {
			String idempleado = (String) request.getParameter("idempleado");
			String myOutputId =(String) request.getParameter("myOutputId");
			
			if(idempleado!=null){
				EmpleadoBean empleado = empleadoEJB.buscarEmpleadosporId(Long.valueOf(idempleado));
				request.setAttribute("empleado", empleado);
			

				
			
			String imageDataBytes = myOutputId.substring(myOutputId.indexOf(",")+1);
		
			 BASE64Decoder decoder = new BASE64Decoder();
	            byte[] imageByte = decoder.decodeBuffer(imageDataBytes);
	            ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
	            BufferedImage image = ImageIO.read(bis);
	           bis.close();
	           
	           
	           Long fecha= new Date().getTime();
	           String nombrefoto= fecha+"_"+empleado.getEmpleadoidentificacion().getCodigoidentificacion()+".jpg";
	          String rutaftp="imagen/foto";
	           
	       	String fileimagendef = Constante.ROOT_FILE_TEMPORARY + File.separator +nombrefoto;
	    	
				File archivo = new File(fileimagendef);
				FileOutputStream ospdf = new FileOutputStream(archivo);
				ospdf.write(imageByte);
				ospdf.close();
				
				for(int i=0;i<=3;i++){//intenta 3 veces la conexion
					
					if(FtpUtilRecursos.checkconexion()){
						
					
			   			if (FtpUtilRecursos.uploadFTP(archivo,rutaftp)) {///sube doc
			   				logger.warn("conecta ftp y sube archivo ");
			   				String nombre = nombrefoto;
			   				

					           empleado.setFotonombre(nombrefoto);
					           empleado.setIdusuariomod(user.getCodusuario());
					           Integer resu = empleadoEJB.actualizaEmpleadofoto(empleado);
							
					           if (resu > 0) {
									PrintWriter out = response.getWriter();
									out.println(empleado.getIdempleado());
									out.close();

								} else {
									throw new LogicaException(
											"Error al editar los datos.");
								}
				   			
				   			break;
				   				
			   			}else{
			   				throw new LogicaException("Error enviando archivo en FTP");
			   			}
					}
	   			
				}
				
				
				
			/*	BufferedImage bimg = ImageIO.read(new File(fileimagendef));
				int width          = bimg.getWidth();
				int height         = bimg.getHeight();
				*/
		
		
				
			}else{
				throw new LogicaException(
						"No se recibe parametro cliente");
			}
			
				
			
			
			} catch (Exception e) {
			logger.error(e.toString(), e.fillInStackTrace());
			response.sendError(1, e.getMessage());
		}

	}
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
