package io.syndesis.qe.accounts;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.Optional;

import io.syndesis.qe.TestConfiguration;
import io.syndesis.qe.exceptions.AccountsException;
import lombok.extern.slf4j.Slf4j;

/**
 * Account directory which manages account information.
 *
 * @author jknetl
 */
@Slf4j
public class AccountsDirectory {

	private ObjectMapper mapper = new ObjectMapper();

	private Map<String, Account> accounts;

	public AccountsDirectory() throws AccountsException {
		load(Paths.get(TestConfiguration.syndesisCredentialsFile()));
	}

	public AccountsDirectory(Path path) throws AccountsException {
		load(path);
	}

	private void load(Path path) throws AccountsException {
		try {
			accounts = mapper.readValue(path.toFile(), new TypeReference<Map<String, Account>>() {
			});
		} catch (IOException e) {
			throw new AccountsException("Cannot load account information.", e);
		}
	}

	public int getTotalAccounts() {
		return accounts.size();
	}

	public Optional<Account> getAccount(String name) {
		return Optional.ofNullable(accounts.get(name));
	}
}
