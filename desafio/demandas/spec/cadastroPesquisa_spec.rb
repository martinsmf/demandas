describe "Rotina de cadastro e pesquisa.", :cadastroEpesquisa do
  before(:each) do
    visit "/"
    fill_in "login", with: "xxxxxxxx"
    fill_in "senha", with: "xxxxxxxx"
    find('input[class="btn btn-success"]').click
  end

  it "1.Realizando cadastro.", :cadastrando do
    click_link "Cadastrar"
    fill_in "codigo", with: "22599-57223" #Deve ser trocado pois não pode repetir o código
    fill_in "nome", with: "Teste 10" #Deve ser trocado pois não pode repetir o nome
    find('input[value="1"]').click
    fill_in "cenarios", with: "10"

    click_button "Cadastrar"

    expect(find("#resultado.alert.alert-success")).to have_content "Cadastro realizado com sucesso!"
  end

  it "2.Realizando pesquisa por codigo", :pesquisa do
    find("#search .search-query").set "12552-02034"
    find("#search .search-query").send_keys :enter

    pesquisa = find("table tbody tr", text: "12552-02034")
    codigo = pesquisa.all("td")[2].text
    expect(codigo).to eql "Início"

    estado = pesquisa.all("td")[0].text
    expect(estado).to eql "12552-02034"
  end

  it "3.Realizando pesquisa por nome", :pesquisaPorNome do
    find("#search .search-query").set "Teste 01"
    find("#search .search-query").send_keys :enter

    pesquisa = find("table tbody tr", text: "12552-02034")
    codigo = pesquisa.all("td")[2].text
    expect(codigo).to eql "Início"

    estado = pesquisa.all("td")[0].text
    expect(estado).to eql "12552-02034"
  end

  it "4.Realizando pesquisa por Responsave", :pesquisaPorResponsavel do
    find("#search .search-query").set "Matheus Martins"
    find("#search .search-query").send_keys :enter

    expect(find(".table-bordered")).to have_content "Matheus Martins"
  end

  it "4.Realizando busca por status", :pesquisaPorStatus do
    find("#search .search-query").set "Execução de Testes"
    find("#search .search-query").send_keys :enter

    expect(find(".table-bordered")).to have_content "Execução de Testes"
  end

  it "5.Realisa busca pelo select", :escolhido do
    filtro = find('select[name="responsavel"]')
    escolha = filtro.all("option").sample.select_option
    puts escolha.text
    while escolha.text == "Selecione..."
      filtro.all("option").sample.select_option
    end
    find(('button[type="submit"]')).click

    expect(find(".table-bordered")).to have_content escolha.text
  end
end
