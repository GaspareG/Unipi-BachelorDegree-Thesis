// BASIC

typedef long long ll;
typedef COLORSET uint32_t
unsigned int N, E;
int color[N];
char label[N];
vector<int> *G[N];
map<COLORSET, ll> M[Q+1][N];

// Get pos-th bit in n
bool getBit(COLORSET n, int pos) { return ((n >> pos) & 1) == 1; }

// Set pos-th bit in n
COLORSET setBit(COLORSET n, int pos) { return n |= 1 << pos; }

// Reset pos-th bit in n
COLORSET clearBit(COLORSET n, int pos) { return n &= ~(1 << pos); }

// Complementary set of a COLORSET
COLORSET getCompl(COLORSET n) { return ((1 << q) - 1) & (~n); }

// COLOR-CODING
void processDP() {
  #pragma omp parallel for schedule(static)
  for (unsigned int u = 0; u < N; u++) M[1][u][setBit(0, color[u])] = 1ll;

  for (unsigned int i = 2; i <= q; i++) {
    #pragma omp parallel for schedule(static)
    for (unsigned int u = 0; u < N; u++) {
      for (int v : G[u]) {
        for (auto d : M[i - 1][v]) {
          COLORSET s = d.first;
          ll f = d.second;
          if (getBit(s, color[u])) continue;
          ll fp = M[i][u][setBit(s, color[u])];
          M[i][u][setBit(s, color[u])] = f + fp;
        }
      }
    }
  }
}

// Colorful sampling
vector<int> randomPathTo(int u) {
  vector<int> P;
  P.push_back(u);
  COLORSET D = getCompl(setBit(0l, color[u]));
  for (int i = q - 1; i > 0; i--) {
    vector<ll> freq;
    for (int v : G[u]) freq.push_back(M[i][v][D]);
    discrete_distribution<int> distribution(freq.begin(), freq.end());
    u = G[u][distribution(eng)];
    P.push_back(u);
    D = clearBit(D, color[u]);
  }
  reverse(P.begin(), P.end());
  return P;
}

set<string> randomColorfulSample(vector<int> X, int r) {
  set<string> W;
  set<vector<int>> R;
  vector<ll> freqX;
  for (int x : X) freqX.push_back(M[q][x][getCompl(0ll)]);
  discrete_distribution<int> distribution(freqX.begin(), freqX.end());
  while (R.size() < (size_t)r) {
    int u = X[distribution(eng)];
    vector<int> P = randomPathTo(u);
    if (R.find(P) == R.end()) R.insert(P);
  }
  for (auto r : R)
    W.insert(L(r));
  return W;
}

// processFrequence
map<string, ll> processFrequency(set<string> W, multiset<int> X) {
  set<string> WR;
  for (string w : W) {
    reverse(w.begin(), w.end());
    WR.insert(w);
  }

  vector<tuple<int, string, COLORSET>> old;

  for (int x : X)
    if (isPrefix(WR, string(&label[x], 1)))
      old.push_back(make_tuple(x, string(&label[x], 1), setBit(0ll, color[x])));

  for (int i = q - 1; i > 0; i--) {
    vector<tuple<int, string, COLORSET>> current;
    current.clear();
    #pragma omp parallel for schedule(static)
    for (int j = 0; j < (int)old.size(); j++) {
      auto o = old[j];
      int u = get<0>(o);
      string LP = get<1>(o);
      COLORSET CP = get<2>(o);
      for (int v : G[u]) {
        if (getBit(CP, color[v])) continue;
        COLORSET CPv = setBit(CP, color[v]);
        string LPv = LP + label[v];
        if (!isPrefix(WR, LPv)) continue;
        #pragma omp critical
        { current.push_back(make_tuple(v, LPv, CPv)); }
      }
    }
    old = current;
  }

  map<string, ll> frequency;
  for (auto c : old) {
    string s = get<1>(c);
    reverse(s.begin(), s.end());
    frequency[s]++;
  }
  return frequency;
}

map<pair<int, string>, ll> randomColorfulSamplePlus(vector<int> X, int r) {
  map<pair<int, string>, ll> W;
  set<vector<int>> R;
  vector<ll> freqX;
  freqX.clear();
  for (int x : X) freqX.push_back(M[q][x][getCompl(0ll)]);
  discrete_distribution<int> distribution(freqX.begin(), freqX.end());
  while (R.size() < (size_t)r) {
    int u = X[distribution(eng)];
    vector<int> P = randomPathTo(u);
    if (R.find(P) == R.end()) R.insert(P);
  }
  for (auto r : R) {
    reverse(r.begin(), r.end());
    W[make_pair(*r.begin(), L(r))]++;
  }
  return W;
}


vector<int> naiveRandomPathTo(int u) {
  vector<int> P;
  set<int> Ps;
  P.push_back(u);
  Ps.insert(u);
  for (int i = q - 1; i > 0; i--) {
    vector<int> Nu;
    for (int j : G[u])
      if (Ps.find(j) == Ps.end()) Nu.push_back(j);
    if (Nu.size() == 0) return P;
    int u = Nu[eng() % Nu.size()];
    Ps.insert(u);
    P.push_back(u);
  }
  return P;
}

map<pair<int, string>, ll> baselineSampler(vector<int> X, int r) {
  set<vector<int>> R;
  while (R.size() < (size_t)r) {
    int u = X[eng() % X.size()];
    vector<int> P = naiveRandomPathTo(u);
    if (P.size() == q && R.find(P) == R.end()) R.insert(P);
  }
  map<pair<int, string>, ll> fx;
  for (auto P : R) fx[make_pair(*P.begin(), L(P))]++;
  return fx;
}

double BCW(set<string> W, map<string, ll> freqA, map<string, ll> freqB) {
  ll num = 0ll;
  ll den = 0ll;
  for (string x : W) {
    ll fax = freqA[x];
    ll fbx = freqB[x];
    num += 2 * min(fax, fbx);
    den += fax + fbx;
  }
  return (double)num / (double)den;
}

double FJW(set<string> W, map<string, ll> freqA, map<string, ll> freqB,
           long long R) {
  ll num = 0ll;
  for (string x : W) {
    ll fax = freqA[x];
    ll fbx = freqB[x];
    num += min(fax, fbx);
  }
  return (double)num / (double)R;
}
