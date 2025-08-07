import java.net.URL;
import javax.swing.*;
import java.awt.Image;
import javax.imageio.ImageIO;

public class E118_modern {
	
	public static void main(String[] args) {
		
		try {
//			URL imageLocation = new URL("https://horstmann.com/java4everyone/duke.gif");
//			URL imageLocation = new URL("https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNnltbnBmZ2xzbjBlcGpmdGF0N2VlNmV3ZjhibmF6MTA2bTk0MGw3YiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/i21tixUQEE7TEqwmYa/giphy.gif");
			URL imageLocation = new URL("https://colourlex.com/wp-content/uploads/2021/02/vine-black-painted-swatch.jpg");
			Image image = ImageIO.read(imageLocation);
			ImageIcon icon = new ImageIcon(image);
			
			JOptionPane.showMessageDialog(null, "Im Doing It!", "DukeGif",
					JOptionPane.PLAIN_MESSAGE, icon);
		} catch(Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null, "Could not load image.");
		}
		
	}
	
}
