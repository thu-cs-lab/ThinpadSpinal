import mill._
import scalalib._
import coursier.maven.MavenRepository

val sonatypeReleases = Seq(
  MavenRepository("https://oss.sonatype.org/content/repositories/releases")
)

val spinalVersion = "1.10.1"

object riscv extends SbtModule {
  def scalaVersion            = "2.13.12"
  override def millSourcePath = os.pwd
  def ivyDeps = Agg(
    ivy"com.github.spinalhdl::spinalhdl-core:$spinalVersion",
    ivy"com.github.spinalhdl::spinalhdl-lib:$spinalVersion"
  )
  def scalacPluginIvyDeps = Agg(
    ivy"com.github.spinalhdl::spinalhdl-idsl-plugin:$spinalVersion"
  )
  def repositoriesTask = T.task {
    super.repositoriesTask() ++ sonatypeReleases
  }
  object test extends SbtModuleTests with TestModule.ScalaTest {
    override def ivyDeps = super.ivyDeps() ++ Agg(
      ivy"org.scalatest::scalatest::3.2.18"
    )
  }
}
