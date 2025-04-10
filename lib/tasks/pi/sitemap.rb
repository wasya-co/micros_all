
module Pi
end

class Pi::Sitemap

  DEFAULT_ORIGIN = 'https://piousbox.com'

  def checks
    out = [
    #   { path: '/2022/09/sturfee-build-pipeline',       selector: 'article.wco-id-100' },
    # ]; tmp = [

      ##
      ## numbers
      ##
      { path: '/2021/06/2399',       selector: 'article.post-2399' },
      { path: '/2022/03/bundler-and-private-repositories',            redirect_to: 'https://wasyaco.com/2022/03/bundler-and-private-repositories' },
      { path: '/2022/03/ruby-on-rails-allow-parameters-to-have-dot',  redirect_to: 'https://wasyaco.com/2022/03/ruby-on-rails-allow-parameters-to-have-dot' },
      { path: '/2022/03/ruby-on-rails-allow-parameters-to-have-dot/', redirect_to: 'https://wasyaco.com/2022/03/ruby-on-rails-allow-parameters-to-have-dot' },
      { path: '/2022/12/japan-securities-clearing-corp-jscc-issues-emergency-margin-call/',       selector: 'article.post-7033' },
      { path: '/2022/08/convert-wireframe-edges-to-a-model-in-maya/', selector: 'article.post-5854' },
      { path: '/2023/08/capturan-a-otro-extranjero-por-delitos-sexuales-contra-menores-de-edad-cometidos-en-medellin/',
        redirect_to: 'https://infiniteshelter.com/2023/08/capturan-a-otro-extranjero-por-delitos-sexuales-contra-menores-de-edad-cometidos-en-medellin/' },
      { path: '/2023/10/does-using-cannabis-lower-blood-pressure', selector: 'article[data-history-node-id="68"]' },
      ##
      ## I
      ##
      { path: '/index.php?p=2399',       redirect_to: '/2021/06/2399' },
      { path: '/index.php?p=7033',       redirect_to: '/2022/12/japan-securities-clearing-corp-jscc-issues-emergency-margin-call/' },

      ##
      ## P
      ##

      # /pages/recruiter-intake-form

      ##
      ## T
      ##

      { path: '/tags/health', selector: '#taxonomy-term-47' },

    ]
    return out
  end
end



