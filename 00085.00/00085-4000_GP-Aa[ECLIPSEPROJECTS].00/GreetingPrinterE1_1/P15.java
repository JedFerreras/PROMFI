import java.net.URL;
import javax.swing.*;
import java.awt.Image;
import javax.imageio.ImageIO;

public class P15 {

	public static void main(String[] args) {
		URL imageLocation = new URL("https://colourlex.com/wp-content/uploads/2021/02/vine-black-painted-swatch.jpg");
		Image image = ImageIO.read(imageLocation);
		ImageIcon icon = new ImageIcon(image);
	}
	
}
