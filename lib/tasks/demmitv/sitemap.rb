
module Demmitv
end

class Demmitv::Sitemap

  DEFAULT_ORIGIN = 'https://demmi.tv'

  def checks
    out = [
    #   { path: '/2022/09/sturfee-build-pipeline',       selector: 'article.wco-id-100' },
    # ]; tmp = [


      { path: '/issues/2024q1-issue',       selector: 'article[data-history-node-id="60"]' },
      { path: '/issues/2024q2-issue',       selector: 'article[data-history-node-id="59"]' },


    ]
    return out
  end
end



