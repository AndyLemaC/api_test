package examples.users;

import com.intuit.karate.junit5.Karate;

public class UsersRunnerTest {  // Renombrada de UsersRunner a UsersRunnerTest

    @Karate.Test
    Karate testUsers() {
        return Karate.run("user-test").relativeTo(getClass());
    }
}



