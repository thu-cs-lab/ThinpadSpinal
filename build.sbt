ThisBuild / scalaVersion          := "2.13.1" // Required due to Spinal compatibility problems
ThisBuild / version               := "1.0.0"
ThisBuild / organization          := ""
ThisBuild / transitiveClassifiers := Seq(Artifact.SourceClassifier)

val spinalVersion = "1.6.0"

lazy val root = (project in file("."))
  .settings(
    name := "thinpad-riscv",
    resolvers ++= Seq(Resolver.sonatypeRepo("releases")),
    libraryDependencies ++= Seq(
      "com.github.spinalhdl" %% "spinalhdl-core" % spinalVersion,
      "com.github.spinalhdl" %% "spinalhdl-lib"  % spinalVersion,
      compilerPlugin(
        "com.github.spinalhdl" %% "spinalhdl-idsl-plugin" % spinalVersion
      )
    ),
    fork := true
  )
