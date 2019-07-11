package com.trs.zhq.util;

import com.trs.hybase.client.TRSException;
import com.trs.hybase.client.TRSRecord;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Expand;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.ResourceUtils;

import java.io.*;
import java.util.Arrays;
import java.util.Properties;


public final class FileUtil {

	private final static Logger LOGGER = LoggerFactory.getLogger(FileUtil.class);

	public static String OS_SEPARATOR = File.separator;

	private static boolean found = false;

	/**
	 * 如果完全匹配某个字符集检测算法, 则该属性保存该字符集的名称. 否则(如二进制文件)其值就为默认值 null, 这时应当查询属性
	 */
	private static String encoding = null;



	/**
	 * @Title: unzip 对zip格式的压缩包进行解压 所需要的jar包是ant.jar
	 * @param
	 * @return_type void
	 * @author Create User At: LJQ
	 * @date Create Date At: 2015-12-8 下午8:28:31
	 */
	public static void unzip(String sourceZip, String destDir) {
			Project p = new Project();
			Expand e = new Expand();
			e.setProject(p);
			e.setSrc(new File(sourceZip));
			e.setOverwrite(false);
			e.setDest(new File(destDir));
			/*
			 * ant下的zip工具默认压缩编码为UTF-8编码， 而winRAR软件压缩是用的windows默认的GBK或者GB2312编码
			 * 所以解压缩时要制定编码格式
			 */
			e.setEncoding(getFilecharset(new File(sourceZip)));
			e.execute();

	}

	//判断编码格式方法
	private static  String getFilecharset(File sourceFile) {
		String charset = "GBK";
		byte[] first3Bytes = new byte[3];
		try {
			boolean checked = false;
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(sourceFile));
			bis.mark(0);
			int read = bis.read(first3Bytes, 0, 3);
			if (read == -1) {
				return charset; //文件编码为 ANSI
			} else if (first3Bytes[0] == (byte) 0xFF
					&& first3Bytes[1] == (byte) 0xFE) {
				charset = "UTF-16LE"; //文件编码为 Unicode
				checked = true;
			} else if (first3Bytes[0] == (byte) 0xFE
					&& first3Bytes[1] == (byte) 0xFF) {
				charset = "UTF-16BE"; //文件编码为 Unicode big endian
				checked = true;
			} else if (first3Bytes[0] == (byte) 0xEF
					&& first3Bytes[1] == (byte) 0xBB
					&& first3Bytes[2] == (byte) 0xBF) {
				charset = "UTF-8"; //文件编码为 UTF-8
				checked = true;
			}
			bis.reset();
			if (!checked) {
				int loc = 0;
				while ((read = bis.read()) != -1) {
					loc++;
					if (read >= 0xF0)
						break;
					if (0x80 <= read && read <= 0xBF) // 单独出现BF以下的，也算是GBK
						break;
					if (0xC0 <= read && read <= 0xDF) {
						read = bis.read();
						if (0x80 <= read && read <= 0xBF) // 双字节 (0xC0 - 0xDF)
							// (0x80
							// - 0xBF),也可能在GB编码内
							continue;
						else
							break;
					} else if (0xE0 <= read && read <= 0xEF) {// 也有可能出错，但是几率较小
						read = bis.read();
						if (0x80 <= read && read <= 0xBF) {
							read = bis.read();
							if (0x80 <= read && read <= 0xBF) {
								charset = "UTF-8";
								break;
							} else
								break;
						} else
							break;
					}
				}
			}
			bis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return charset;
	}


	/**
	 * 删除一个文件或者目录
	 *
	 * @param targetPath
	 *            文件或者目录路径
	 * @IOException 当操作发生异常时抛出
	 */
	public static void deleteFile(String targetPath) throws IOException {
		File targetFile = new File(targetPath);
		try {
			if (targetFile.exists() && targetFile.isDirectory()) {
				FileUtils.deleteDirectory(targetFile);
			} else if (targetFile.exists() && targetFile.isFile()) {
				targetFile.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String getJarRootPath() throws FileNotFoundException {
		String path = ResourceUtils.getURL("classpath:").getPath();
		//=> file:/root/tmp/demo-springboot-0.0.1-SNAPSHOT.jar!/BOOT-INF/classes!/
		//创建File时会自动处理前缀和jar包路径问题  => /root/tmp
		File rootFile = new File(path);
		if(!rootFile.exists()) {
			System.out.println("根目录不存在, 重新创建");
			rootFile = new File("");
			System.out.println("重新创建的根目录: "+rootFile.getAbsolutePath());
		}
		System.out.println("项目根目录: "+rootFile.getAbsolutePath());        //获取的字符串末尾没有分隔符 /
		return rootFile.getAbsolutePath();
	}

	public static String getDataType(int dataType) {
		switch (dataType) {
			case 0:
				return "pindao";
			case 1:
				return "mocai";
			case 2:
				return "shucai";
			case 3:
				return "xinyuan";
			case 4:
				return "wangluocaiji";
			case 5:
				return "erjinzhi";
			case 6:
				return "fenxigonghengwenjian";
			case 7:
				return "chengxu";
			default:
				return "qita";
		}
	}

	public static String getRootPath(){
		String rootPath = getFileProp().getProperty("fileRootPath");
		return rootPath;
	}

	public static Properties getFileProp(){
        Properties properties = new Properties();
        try {
            properties.load(FileUtil.class.getClassLoader().getResourceAsStream("file.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return properties;
    }


    /*







    */
    public static String formatFileName(TRSRecord record, String dbName) {
		String fileName = "";
		try {
			fileName = record.getString("TFileName");
			String name = record.getString("TFileName");
			String fileType = name.substring(name.lastIndexOf("."));
			switch (dbName) {
				case "sj_pinpu":
					fileName = record.getString("SSQUIPMENT_CHAN") + "_" + record.getString("SCOMFREQSPAN")
							+ "_(" + record.getString("SORBIT_POS") + "_" + record.getString("SSATELLITE_NAME") + ")_"
							+ record.getString("NFREQ_START") + "MHz_" + record.getString("NFREQ_STOP") + "MHz_"
							+ record.getString("NBANDDATA_FFTNUM") + "_" + record.getString("DDATA_RECBTIME") + "_"
							+ record.getString("DDATA_RECETIME") + ".freqDat";
					break;
				case "sj_mocai":
					fileName = record.getString("SSQUIPMENT_CHAN") + "_" + record.getString("SCOMFREQSPAN")
							+ "_(" + record.getString("SORBIT_POS") + "_" + record.getString("SSATELLITE_NAME") + ")_"
							+ record.getString("NFREQ_START") + "MHz_" + record.getString("NFREQ_STOP") + "MHz_"
							+ record.getString("NDATA_SAMPLERATE") + "_" + record.getString("DDATA_RECBTIME") + "_"
							+ record.getString("DDATA_RECETIME") + ".anaDat";
					break;
				case "sj_shucai":
					fileName = record.getString("SSQUIPMENT_CHAN") + "_" + record.getString("SCOMFREQSPAN")
							+ "_(" + record.getString("SORBIT_POS") + "_" + record.getString("SSATELLITE_NAME") + ")_"
							+ record.getString("NCARRIERFREQ") + "MHz_" + record.getString("SMODULATIONMODE") + "_"
							+ record.getString("NINFORATE") + "_" + record.getString("DDATA_RECBTIME") + "_"
							+ record.getString("DDATA_RECETIME") + ".digDat";
					break;
				case "sj_xinyuan":
					fileName = record.getString("SCOMFREQSPAN") + "_(" + record.getString("SORBIT_POS") + "_"
							+ record.getString("SSATELLITE_NAME") + ")_" + record.getString("NCARRIERFREQ") + "MHz_"
							+ record.getString("SSOURCETYPE") + "_" + record.getString("SSOURCECODETYPE") + "_"
							+ record.getString("DDATA_RECBTIME") + "_" + record.getString("DDATA_RECETIME") + ".sDat";
					break;
				case "sj_wangluo":
					fileName = record.getString("SORBIT_POS") + "_" + record.getString("SSATELLITE_NAME") + ")_"
							+ record.getString("NCARRIERFREQ") + "MHz_" + record.getString("SMODULATIONMODE") + "_"
							+ record.getString("NMODULATIONRATE") + "_" + record.getString("SNETSIGNALTYPErecord")
							+ "_" + record.getString("DDATA_RECBTIME") + "_" + record.getString("DDATA_RECETIME") + fileType;
					break;
				case "sj_erjinzhi":
				case "sj_fenxi":
					fileName = record.getString("SEQUIPMENT") + "_" + record.getString("SFILENAME") + fileType;
					break;
			}
		} catch (TRSException e) {
			e.printStackTrace();
		}

		return fileName;
    }

    public static String concatFileName() {

        return "";
    }


}
