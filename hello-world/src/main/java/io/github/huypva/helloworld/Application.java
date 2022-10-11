package io.github.huypva.helloworld;

import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import java.util.function.Function;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.function.context.FunctionRegistration;
import org.springframework.cloud.function.context.FunctionType;
import org.springframework.context.ApplicationContextInitializer;
import org.springframework.context.support.GenericApplicationContext;

@SpringBootApplication
public class Application implements ApplicationContextInitializer<GenericApplicationContext> {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	public Function<APIGatewayProxyRequestEvent, String> welcome() {
		return requestEvent -> "Welcome "
				+ requestEvent.getQueryStringParameters().get("userName")
				+ " to the lambda function";
	}

	@Override
	public void initialize(GenericApplicationContext context) {
		context.registerBean("welcome", FunctionRegistration.class,
				() -> new FunctionRegistration<>(welcome())
						.type(FunctionType.from(APIGatewayProxyRequestEvent.class).to(String.class)));
	}

}
