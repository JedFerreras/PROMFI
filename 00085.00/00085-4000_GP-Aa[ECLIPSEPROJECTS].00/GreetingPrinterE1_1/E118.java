import java.net.URL;
import javax.swing.ImageIcon;
import javax.swing.JOptionPane;

public class E118 {
	
	public static void main(String[] args) throws Exception
	{
//		chunk 1 - code from 2017 book
//		URL imageLocation = new URL(
//				"http://horstmann.com/java4everyone/duke.gif");
//		JOptionPane.showMessageDialog(null,  "Hello", "Title",
//				JOptionPane.PLAIN_MESSAGE, new ImageIcon(imageLocation));
		
//		chunk2 - code from chatgpt still deprecated based on old methods
		//		URL to duke image
		URL imageLocation = new URL("https://horstmann.com/java4everyone/duke.gif");
		
//		try loading the image
		ImageIcon icon = new ImageIcon(imageLocation);
		
//		sanity check to make sure image is actually loaded
		if (icon.getIconWidth()==1) {
			JOptionPane.showMessageDialog(null, "Failed to load image");
		} else {
			JOptionPane.showMessageDialog(null, "Hello", "Title",
					JOptionPane.PLAIN_MESSAGE, icon);
		}
	}
}
