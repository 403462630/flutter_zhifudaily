

enum DomainType {
  ZHI_HU_DOMAIN
}

class DomainConfig {
  static final Map<DomainType, String> _productDomains = {
    DomainType.ZHI_HU_DOMAIN : "https://news-at.zhihu.com/"
  };

  static final Map<DomainType, String> _debugDomains = {
    DomainType.ZHI_HU_DOMAIN : "https://news-at.zhihu.com/"
  };

  static bool debug = false;

  static String getDomain(DomainType type) {
    if (debug) {
      return _debugDomains[type];
    } else {
      return _productDomains[type];
    }
  }
}
