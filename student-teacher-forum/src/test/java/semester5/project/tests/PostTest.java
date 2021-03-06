package semester5.project.tests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Calendar;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import semester5.project.App;
import semester5.project.model.entity.AppUser;
import semester5.project.model.entity.Post;
import semester5.project.model.repository.PostDao;
import semester5.project.service.UserService;

@SuppressWarnings("deprecation")
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(App.class)
@WebAppConfiguration

@Transactional
public class PostTest {

	@Autowired
	private PostDao postdao;

	@Autowired
	private UserService userService;

	@Test
	public void TestSave() {
		AppUser user = new AppUser("test@gmail.com", "test123", "test1", "test2");
		userService.register(user);
		Post post = new Post("This is a Test Post");
		post.setUser(user);
		postdao.save(post);

		assertNotNull("Non-null ID", post.getId());
		assertNotNull("Non-null date", post.getUpdated());

		Post retrieved = postdao.findOne(post.getId());
		assertEquals("Matching Post", post, retrieved);
	}

	@Test
	public void testFindLatest() {
		AppUser user = new AppUser("test@gmail.com", "test123", "test1", "test2");
		userService.register(user);
		Calendar calendar = Calendar.getInstance();
		Post Last = null;

		for (int i = 0; i < 10; i++) {
			calendar.add(Calendar.DAY_OF_YEAR, 1);
			Post state = new Post("Post" + i, calendar.getTime());
			state.setUser(user);
			postdao.save(state);
			Last = state;
		}
		Post ret = postdao.findFirstByOrderByUpdatedDesc();
		assertEquals("Latest Post", Last, ret);
	}

}
