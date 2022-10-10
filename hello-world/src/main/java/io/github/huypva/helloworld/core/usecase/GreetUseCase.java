package io.github.huypva.helloworld.core.usecase;

import io.github.huypva.helloworld.core.entity.Greeting;

/**
 * @author huypva
 */
public interface GreetUseCase {

  Greeting greet(String name);
}
