package org.paasta.caas.dashboard.common.model;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * CommonContainer Model 클래스
 *
 * @author REX
 * @author CISS
 * @author Hyungu Cho
 * @version 1.0
 * @since 2018.08.13
 */
@Data
public class CommonContainer {
   /* For PodTemplateSpec -- START */
   String name;
   String image;
   List<String> args;
   List<Map> env;
   List<CommonPort> ports;
   CommonResourceRequirement resources;
   List<String> command;

//   private List<EnvFromSource> envFrom;

//   private String imagePullPolicy;

//   private CommonLifecycle lifecycle;

//   private CommonProbe livenessProbe;

//   private CommonProbe readinessProbe;

//   private CommonSecurityContext securityContext;

//   private boolean stdin;

//   private boolean stdinOnce;

//   private String terminationMessagePath;
//
//   private String terminationMessagePolicy;
//
//   private boolean tty;
//
//   List<VolumeMount> volumeMounts;
//
//   List<VolumeDevice> volumeDevices;
//
//   String workingDir;
   /* For PodTemplateSpec -- END   */
}
