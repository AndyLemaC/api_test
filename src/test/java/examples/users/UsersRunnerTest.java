package examples.users;

import com.intuit.karate.junit5.Karate;

public class UsersRunnerTest {

    @Karate.Test
    Karate testUserCrudSequence() {
        return Karate.run("classpath:examples/users/user-crud-sequential.feature");
    }

    @Karate.Test
    Karate testUserCrud() {
        return Karate.run("classpath:examples/users/user-crud.feature")
                .tags("@healthcheck,@create,@read,@update,@read,@delete");
    }
}


